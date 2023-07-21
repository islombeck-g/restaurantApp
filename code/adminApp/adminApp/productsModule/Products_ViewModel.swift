import Foundation
import FirebaseFirestore

class Products_ViewModel:ObservableObject{
    
    private var service = ProductService()
    @Published var productsInWarehouse = [Product]()//
    @Published var productsInBasket = [Product]()// в корзине
    //    @Published var product:Product = Product(id: "", name: "", count: 0, price: 0)
    @Published var isLoading = false // это добавил
    
    init(){
        self.getProducts()
    }
    func getProducts() {
        self.isLoading = true
        service.getFromAPI { products in
            self.productsInWarehouse = products
            self.isLoading = false
        }
    }
    func addProductToDB(){
        //MARK: получаем данные лд
        print("productTo add \(productsInBasket)")
        let products = productsInBasket
        self.productsInBasket = []
        for var i in products {
            self.service.getDataWithName(name: i.name){ product in
                guard product != nil else{
                    self.service.addToAPI(product: i)
                    self.getProducts()
                    return
                }
                i.count += product!.count
                self.service.deleteAPI(product: product!){t in
                    self.service.addToAPI(product: i)
                    self.getProducts()
                }
                                       
            }
        }
    }
    func deleteProductFromDB(product:Product){
        self.service.deleteAPI(product: product) { error in
               if error != "1" {
                   print("Error deleting product: \(error)")
               } else {
                   print("Product successfully deleted!")
                   // Вызываем getProducts только после успешного удаления
                   self.getProducts()
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
    
    func countSumInBasket()->Double{
        var sum = 0.0
        for i in self.productsInBasket{
            sum += (Double(i.count) * i.price/100.0)
        }
        return sum
    }
    private func finalList (list: [Product]) -> [Product] {
        var newList = [Product]()
        print ("list = \(list)")
        for i in list {
            if let index = newList.firstIndex (where: {$0.name == i.name}) {
                newList[index].count += i.count
            }else{
                newList.append(i)
            }
        }
        return newList
    }
}
//func get_Products(){
//
//    self.productsInWarehouse = []
//    let db = Firestore.firestore()
//    db.collection("products").getDocuments{ snapshot, error in
//        if error == nil{
//            if let snapshot = snapshot{
//                DispatchQueue.main.async {
//                    self.productsInWarehouse = snapshot.documents.map{i in
//                        return Product(id: i.documentID, name: i["name"] as! String , count: i["count"] as! Int, price: i["price"] as! Double)
//                    }
//                }
//
//            }
//        }else{
//            print("error in Products_ViewModel in get_Products: \(String(describing: error))")
//
//        }
//
//    }
//}
