import Foundation
import FirebaseFirestore

class ProductAPI{
    
    let db = Firestore.firestore()
    
    //MARK: use like this
    // productAPI.getData{products in print(products) }
    func getData (completion: @escaping ([Product]) -> Void) {
        var products: [Product] = [Product]()
        
        db.collection("products").getDocuments { snapshot, error in
            guard error == nil else {
                print ("error in ProductAPI in getData, error: \(String(describing: error))")
                completion([])
                return
            }
            guard let snapshot = snapshot else {
                print ("error in ProductAPI in getData, snapshot: \(String(describing: error))")
                completion([])
                return
            }
            DispatchQueue.main.async {
                print ("productApi getData_start")
                products = snapshot.documents.compactMap { document->Product? in
                    guard let name = document["name"] as? String,
                          let count = document["count"] as? Int,
                          let price = document["price"] as? Double
                    else {
                        print("error in ProductAPI in getData, compactMap")
                        return nil
                    }
                    return Product (id: document.documentID, name: name, count: count, price: price)
                }
                print ("productApi getData_end")
                completion (products)
            }
        }
        
    }
    
    func pushData (product: Product) {
        
        db.collection("products").addDocument(data: [
            "name": product.name,
            "count": product.count,
            "price": product.price
        ]){ error in
            guard error == nil else {
                print("error in ProductAPI in pushData: \(String(describing: error))")
                return
            }
            
        }
    }
    func deleteProduct (product:Product, completion: @escaping (String) -> Void) {
        db.collection("products").document(product.id ?? "").delete { error in
            if let error = error {
                print ("Error deleting document: \(error)")
                completion("error in deleting document")
            } else {
                print ("Product successfully deleted!")
                completion("1")
            }
        }
    }
    
    func getDataWithName (name: String, completion: @escaping (Product?) -> Void) {
        db.collection("products").whereField("name", isEqualTo: name).getDocuments { snapshot, error in
            guard error == nil else {
                print ("Error in ProductAPI getDataWithName, error: \(String(describing: error))")
                completion (nil)
                return
            }
            
            guard let snapshot = snapshot else {
                print ("Error in ProductAPI getDataWithName, snapshot: \(String(describing: error))")
                completion (nil)
                return
            }
            guard let document = snapshot.documents.first,
                  let name = document["name"] as? String,
                  let count = document["count"] as? Int,
                  let price = document["price"] as? Double else {
                print("Error in ProductAPI getDataWithName, data parsing failed")
                completion(nil)
                
                return
            }
            let product = Product(id: document.documentID, name: name, count: count, price: price)
            completion(product)

        }
    }
    
}
