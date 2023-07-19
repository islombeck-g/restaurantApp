import Foundation
import FirebaseFirestore

class ProductAPI{
    
    let db = Firestore.firestore()
    //MARK: use like this
    // productAPI.getData{products in print(products) }
    func getData(completion: @escaping ([Product]) -> Void){
        var products:[Product] = [Product]()
        
        db.collection("products").getDocuments{snapshot, error in
            guard error == nil else {
                print("error in ProductAPI in getData, error: \(String(describing: error))")
                completion([])
                return
            }
            guard let snapshot = snapshot else{
                print("error in ProductAPI in getData, snapshot: \(String(describing: error))")
                completion([])
                return
            }
            DispatchQueue.main.async {
                print("productApi getData_start")
                products = snapshot.documents.compactMap{ document->Product? in
                    guard let name = document["name"] as? String,
                          let count = document["count"] as? Int,
                          let price = document["price"] as? Double
                    else {
                        print("error in ProductAPI in getData, compactMap")
                        return nil
                    }
                    return Product(id: document.documentID, name: name, count: count, price: price)
                }
                print("productApi getData_end")
                completion(products)
            }
        }
        
    }
    func pushData(product: Product){
        db.collection("Product").addDocument(data: [
            "name": product.name,
            "count": product.count,
            "price": product.price
        ]){error in
            guard error == nil else{
                print("error in ProductAPI in pushData: \(String(describing: error))")
                return
            }
    
        }
    }
    func deleteProduct(product:Product){
        db.collection("product").document(product.id ?? "").delete{error in
            if let error = error{
                print("Error deleting document: \(error)")
            }else{
                print("Product successfully deleted!")
            }
        }
    }
}
