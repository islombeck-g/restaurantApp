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
                        self.finalList()
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
            
        self.finalListBasket()
    
        
    }
    func addToWarehouse(){
        guard !self.productsInBasket.isEmpty else {return}
        let db = Firestore.firestore()
        
        for i in productsInBasket{
            db.collection("products").addDocument(data: ["name": i.name, "count": i.count, "price": i.price]){error in
                if error != nil{
                    print("error in ProductViewModel in addToWarehouse: \(String(describing: error))")
                }
            }
        }
        self.productsInBasket = []
        self.get_Products()
        
        
    }
    func finalList(){
        var newList = [Product]()
        for i in productsInWarehouse{
            if let index = newList.firstIndex(where: {$0.name == i.name}){
                newList[index].count += i.count
                
            }else{
                newList.append(i)
            }

        }
        self.productsInWarehouse = []
        self.productsInWarehouse = newList
    }
    
    private func finalListBasket(){
        var newList = [Product]()
        for i in productsInBasket{
            if let index = newList.firstIndex(where: {$0.name == i.name}){
                newList[index].count += i.count
            }else{
                newList.append(i)
            }

        }
        self.productsInBasket = newList
    }
    
}
