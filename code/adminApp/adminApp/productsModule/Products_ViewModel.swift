import Foundation
import FirebaseFirestore

class Products_ViewModel:ObservableObject{
    var firebase: FireBase_ViewModel
    @Published var product:Product = Product(id: "", name: "", count: 0, price: 0)
    
    @Published var productsInWarehouse = [Product]()//
    @Published var productsInBasket = [Product]()// в корзине
    @Published var isLoading = false // это добавил
    

    init(firebase: FireBase_ViewModel) {
            self.firebase = firebase
        }
    func progress(){
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            self.isLoading = false
        }
        
        
    }
    
    
    func get_Products(){
        
        self.productsInWarehouse = []
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
        
        self.productsInBasket = self.finalList(list: self.productsInBasket)
        
    }
    func addProductToDB(product: [Product], completion: @escaping () -> Void){
        
        print("productTo add \(product)")
        addToDB(product: product){
            
            self.someFunc()
            completion()
            
        }
        
        
        
    }
    private func addToDB(product:[Product], completion: @escaping () -> Void){
        guard !product.isEmpty else {return}
        let db = Firestore.firestore()
        var counter = 0
        for i in product{
            db.collection("products").addDocument(data: ["name": i.name, "count": i.count, "price": i.price]){error in
                if error != nil{
                    print("error in ProductViewModel in addToWarehouse: \(String(describing: error))")
                }else{
                    counter += 1
                    if counter == product.count{
                        completion()
                    }
                }
            }
        }
        self.get_Products()
        print("productsInWarehouse = \(productsInWarehouse)")
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
        self.get_Products()
        
    }
    
    
    private func someFunc(){
        let array = self.finalList(list: self.productsInWarehouse)
        print("NewArray = \(array)")
        for i in self.productsInWarehouse{
            self.deleteProductFromDB(product: i)
        }
        self.productsInWarehouse = []
        addToDB(product: array){}
        
        get_Products()
        
    }
    private func finalList(list:[Product])->[Product]{
        var newList = [Product]()
        print("list = \(list)")
        for i in list{
            if let index = newList.firstIndex(where: {$0.name == i.name}){
                newList[index].count += i.count
                print("a")
            }else{
                newList.append(i)
                print("b")
            }
        }
        
        
        return newList
        
    }
    
}
