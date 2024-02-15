import Foundation
import FirebaseFirestore

final class ProductsAPI {
    
    let db = Firestore.firestore()
    
    func get(completion: @escaping ([Product]?, ProductsAPIError?) -> Void) {
        var products: [Product] = [Product]()
        
        db.collection("products").getDocuments { snapshot, error in
            guard error == nil else {
                print ("error in ProductAPI in getData, error: \(String(describing: error))")
                completion(nil, .serverError("Network error"))
                return
            }
            guard let snapshot = snapshot else {
                print ("error in ProductAPI in getData, snapshot: \(String(describing: error))")
                completion(nil, .serverError("Server data error"))
                return
            }
            DispatchQueue.main.async {
                products = snapshot.documents.compactMap { document -> Product? in
                    guard let name = document["name"] as? String,
                          let count = document["count"] as? Double,
                          let price = document["price"] as? Double
                    else {
                        print("error in ProductAPI in getData, compactMap")
                        return nil
                    }
                    return Product(id: document.documentID, name: name, price: price, count: count)
                }
                completion(products, nil)
            }
        }
        
    }
    
    func deleteProduct (product:Product) -> ProductsAPIError? {
        do {
            db.collection("products").document(product.id).delete()
            return nil
        }
    }
    
    func add(product: Product) {
        
        self.db.collection("products").whereField("name", isEqualTo: product.name).getDocuments { snapshot, error in
            if let error = error {
                
                print("Error getting documents: \(error)")
                
            } else {
                if let document = snapshot?.documents.first {
                    
                    let newCount = document.data()["count"] as! Double + product.count
                    document.reference.setData([
                        "count": newCount
                    ], merge: true)
                } else {
                    self.db.collection("products").addDocument(data: [
                        "name": product.name,
                        "count": product.count,
                        "price": product.price
                    ])
                }
                
            }
        }
    }
    
    func getMarketProducts(completion: @escaping([MarketProduct]?, ProductsAPIError?) -> Void) {
        var products: [MarketProduct] = [MarketProduct]()
        
        db.collection("Products").getDocuments { snapshot, error in
            guard error == nil else {
                print ("error in ProductAPI in getData, error: \(String(describing: error))")
                completion(nil, .serverError("Network error"))
                return
            }
            guard let snapshot = snapshot else {
                print ("error in ProductAPI in getData, snapshot: \(String(describing: error))")
                completion(nil, .serverError("Server data error"))
                return
            }
            DispatchQueue.main.async {
                print ("productApi getData_start")
                products = snapshot.documents.compactMap { document -> MarketProduct? in
                    guard let name = document["name"] as? String,
                          let price = document["price"] as? Double
                    else {
                        print("error in ProductAPI in getData, compactMap")
                        return nil
                    }
                    return MarketProduct(id: document.documentID, name: name, price: price)
                }
                completion(products, nil)
            }
        }
    }
}

//MARK: for download productList
//func forOne() {
//    let productCollection = Firestore.firestore().collection("Products")
//
//    for i in ConstProducts {
//        print("Processing product \(i.name)")
//        do {
//            // Create a reference to a new document with a random id
//            let newProductRef = productCollection.document()
//            // Set the data of the new document with the product name, price and id
//            try newProductRef.setData(from: Products(id: newProductRef.documentID, name: i.name, price: i.price), merge: false)
//        } catch let error {
//            print("Error updating document for product \(i.name): \(error)")
//        }
//    }
//}
//let ConstProducts = [
//    MarketProduct(id: "P001", name: "Apple", price: 0.99),
//    MarketProduct(id: "P002", name: "Banana", price: 0.79),
//    MarketProduct(id: "P003", name: "Carrot", price: 0.59),
//    MarketProduct(id: "P004", name: "Date", price: 1.29),
//    MarketProduct(id: "P005", name: "Egg", price: 0.19),
//    MarketProduct(id: "P006", name: "Flour", price: 2.49),
//    MarketProduct(id: "P007", name: "Grape", price: 2.99),
//    MarketProduct(id: "P008", name: "Honey", price: 4.99),
//    MarketProduct(id: "P009", name: "Ice cream", price: 3.49),
//    MarketProduct(id: "P010", name: "Jam", price: 2.99),
//    MarketProduct(id: "P011", name: "Kiwi", price: 0.99),
//    MarketProduct(id: "P012", name: "Lemon", price: 0.49),
//    MarketProduct(id: "P013", name: "Milk", price: 1.99),
//    MarketProduct(id: "P014", name: "Noodle", price: 1.49),
//    MarketProduct(id: "P015", name: "Olive", price: 3.99),
//    MarketProduct(id: "P016", name: "Peanut", price: 2.49),
//    MarketProduct(id: "P017", name: "Quinoa", price: 4.99),
//    MarketProduct(id: "P018", name: "Rice", price: 1.99),
//    MarketProduct(id: "P019", name: "Salmon", price: 9.99),
//    MarketProduct(id: "P020", name: "Tomato", price: 0.99),
//    MarketProduct(id: "P021", name: "Udon", price: 2.99),
//    MarketProduct(id: "P022", name: "Vanilla", price: 3.99),
//    MarketProduct(id: "P023", name: "Butter", price: 2.99),
//    MarketProduct(id: "P024", name: "Xylitol", price: 5.99),
//    MarketProduct(id: "P025", name: "Yogurt", price: 1.99),
//    MarketProduct(id: "P026", name: "Zucchini", price: 1.49),
//    MarketProduct(id: "P027", name: "Bread", price: 2.49),
//    MarketProduct(id: "P028", name: "Cheese", price: 3.99),
//    MarketProduct(id: "P029", name: "Butter", price: 2.99),
//    MarketProduct(id: "P030", name: "Sugar", price: 1.49),
//    MarketProduct(id: "P031", name: "Salt", price: 0.99),
//    MarketProduct(id: "P032", name: "Pepper", price: 1.99),
//    MarketProduct(id: "P033", name: "Coffee", price: 4.99),
//    MarketProduct(id: "P034", name: "Tea", price: 3.99),
//    MarketProduct(id: "P035", name: "Water", price: 0.99),
//    MarketProduct(id: "P036", name: "Juice", price: 2.99),
//    MarketProduct(id: "P037", name: "Soda", price: 1.99),
//    MarketProduct(id: "P038", name: "Beer", price: 3.99),
//    MarketProduct(id: "P039", name: "Wine", price: 9.99)]
