
import Foundation
import FirebaseFirestore


class FireBase_ViewModel:ObservableObject{
    
   
    
}


//@Published var arrayOfMeal = [Meal]()
//@Published var arrayOfProducts = [Product]()
//private let db = Firestore.firestore()
//let group = DispatchGroup()
//
//init(){
//    getData()
//}
//func getData(){
//        group.enter()
//        getProductsArray()
//        group.notify(queue: .main){
//            self.getMeal()
//            print("All data retrieved.")
//        }
//    }
//
//func getProductsArray(){
//    db.collection("products").getDocuments{snapshot, error in
//        guard error != nil || snapshot != nil else {
//            print("error in Menu_ViewModel in getProductsToCheck: \(String(describing: error))")
//            return
//        }
//        DispatchQueue.main.async {
//            print(1.1)
//            self.arrayOfProducts = snapshot!.documents.compactMap { product -> Product? in
//                guard let name = product["name"] as? String,
//                      let count = product["count"] as? Int,
//                      let price = product["price"] as? Double else {
//                    print("error")
//                    return nil
//                }
//                print("aaaa")
//                return Product(id: product.documentID, name: name, count: count, price: price)
//            }
//            print(1)
//            self.group.leave()
//        }
//    }
//
//}
//func getMeal(){
//    db.collection("meal").getDocuments{snapshot, error in
//        guard error == nil else {
//            print("error in get data from server GETMEAL in MENU_VIEWMODEL: \(String(describing: error))")
//            return
//        }
//        guard snapshot != nil else {
//            print("error in MENU_VIEWMODEL in GETMEAL snapshot is empty")
//            return
//        }
//        DispatchQueue.main.async {
//            print(2.1)
//            self.arrayOfMeal = snapshot!.documents.compactMap { document -> Meal? in
//                guard let name = document["name"] as? String,
//                      let icon = document["icon"] as? String,
//                      let productsData = document["products"] as? [[String: Any]] else{
//                    print("Error in Meal initialization")
//                    return nil
//                }
//                let products = productsData.compactMap{product -> MealProduct? in
//                    guard let count = product["countOfProduct"] as? Int,
//                          let name = product["nameOfProduct"] as? String else{
//                        print ("error in meal Product Initialization")
//                        return nil
//                    }
//                    print("________________")
//                    print(self.arrayOfProducts)
//                    print("________________")
//                    return MealProduct(countOfProduct: count, nameOfProduct: name, haveOrNot: self.checkProduct(name: name, count: count))
//                }
//                return Meal(id: document.documentID, name: name, icon: icon, products: products)
//            }
//            print(2)
////                self.group.leave()
//        }
//    }
//}
//func checkProduct(name:String, count:Int)->Bool{
//    for i in arrayOfProducts{
//        if name == i.name{
//            if count <= i.count{
//                return true
//            }
//            return false
//        }
//    }
//    return false
//}
//func addMeal(newMeal:Meal){
//    if checkDataToAdd(newMeal: newMeal){
//        let db = Firestore.firestore()
//
//        var productsData = [[String: Any]]()
//
//        for i in newMeal.products{
//            let productData:[String:Any] = [
//                "countOfProduct": i.countOfProduct,
//                "nameOfProduct": i.nameOfProduct
//            ]
//            productsData.append(productData)
//        }
//        let mealData:[String:Any] = [
//            "icon": newMeal.icon,
//            "name": newMeal.name,
//            "products": productsData
//        ]
//        db.collection("meal").addDocument(data: mealData)
//    }else{
//        print("??????error in menu_ViewModel in addMeal")
//    }
//
//
//}
//private func checkDataToAdd(newMeal:Meal) -> Bool{
//    guard !newMeal.name.isEmpty else{return false}
//    guard !newMeal.icon.isEmpty else{return false}
//    guard !newMeal.products.isEmpty else {return false}
//    return true
//}
