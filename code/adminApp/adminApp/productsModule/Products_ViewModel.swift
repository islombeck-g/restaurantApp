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
                        self.productsInWarehouse = self.finalList(list: self.productsInWarehouse)
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
        
        self.productsInBasket = self.finalList(list: self.productsInBasket)
        
        
    }
    func addProductToDB(product: [Product]){
        
        addToDB(product: product)
        someFunc()
        
    }
    func addToDB(product:[Product]){
        guard !product.isEmpty else {return}
        let db = Firestore.firestore()
        
        for i in product{
            db.collection("products").addDocument(data: ["name": i.name, "count": i.count, "price": i.price]){error in
                if error != nil{
                    print("error in ProductViewModel in addToWarehouse: \(String(describing: error))")
                }
            }
        }
        self.productsInBasket = []
    }
    func countSumInBasket()->Double{
        var sum = 0.0
        for i in self.productsInBasket{
            sum += (Double(i.count) * i.price/100.0)
        }
        return sum
    }
    func deleteProductFromDB(product:Product){
        let db = Firestore.firestore()
        db.collection("products").document(product.id!).delete{error in
            if let error = error{
                print("????????Error deleting document: \(error)")
            }else{
                print("!!!!!!!!Document successfully deleted!")
            }
        }
    }
    
    
    private func someFunc(){
        let array = self.finalList(list: self.productsInWarehouse)
        
        for i in self.productsInWarehouse{
            self.deleteProductFromDB(product: i)
        }
        self.productsInWarehouse = []
        addProductToDB(product: array)
        
        get_Products()
        
    }
    private func finalList(list:[Product])->[Product]{
        var newList = [Product]()
        for i in list{
            if let index = newList.firstIndex(where: {$0.name == i.name}){
                newList[index].count += i.count
            }else{
                newList.append(i)
            }
        }
        
        return newList
        
    }
    
}
