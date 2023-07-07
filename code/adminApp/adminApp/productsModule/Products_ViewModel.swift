import Foundation
import FirebaseFirestore

class Products_ViewModel:ObservableObject{

    @Published var product:Product = Product(id: "", name: "", count: 0, price: 0)
    @Published var listOfProducts = [Product]()
    
    func get_Products(){
        let db = Firestore.firestore()
        
        db.collection("products").getDocuments{ snapshot, error in
            if error == nil{
                
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        self.listOfProducts = snapshot.documents.map{i in
                            return Product(id: i.documentID, name: i["name"] as! String , count: i["count"] as! Int, price: i["price"] as! Int)
                        }
                    }
                }
                
            }else{
                print("error in Products_ViewModel in get_Products: \(String(describing: error))")
            }
            
        }
    }
    
    func add_newProduct(){
            
    }
    
    
    
}
