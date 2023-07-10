import Foundation
import FirebaseFirestore

class Products_ViewModel:ObservableObject{

    @Published var product:Product = Product(id: "", name: "", count: 0, price: 0)
    @Published var productsInWarehouse = [Product]()//
    @Published var productsInBasket = [Product]()// в корзине
    
    func get_Products(){
        let db = Firestore.firestore()
        
        db.collection("products").getDocuments{ snapshot, error in
            if error == nil{
                
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        self.productsInWarehouse = snapshot.documents.map{i in
                            return Product(id: i.documentID, name: i["name"] as! String , count: i["count"] as! Int, price: i["price"] as! Double)
                        }
                    }
                }
                
            }else{
                print("error in Products_ViewModel in get_Products: \(String(describing: error))")
            }
            
        }
    }
    
    func addToBasket(product:Product){
        guard !product.name.isEmpty && product.count != 0 else{
            print("error in productViewModel in addToBasket")
            return
        }
        self.productsInBasket.append(Product.init(id: "", name: product.name, count: product.count, price: product.price))
            
        
        
    }
    
    
    
}
