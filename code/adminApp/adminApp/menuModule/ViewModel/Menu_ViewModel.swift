
import Foundation
import FirebaseFirestore


class Menu_ViewModel:ObservableObject{
    
    @Published var arrayOfMealIn = [Meal]()
    @Published var name = ""
    @Published var icon = ""
    private var arrayOfProducts = [Product]()
    
    func getMeal() {
        self.arrayOfMealIn = [] // Инициализация пустого массива
        
        let db = Firestore.firestore()
        db.collection("meal").getDocuments { snapshot, error in
            if let error = error {
                print("Error in Menu_ViewModel in getMeal(): \(error)") // Печать ошибки в случае её наличия
                return
            }
            
            guard let snapshot = snapshot else {
                print("Snapshot is nil") // Про верка наличия snapshot
                return
            }
            
            DispatchQueue.main.async {
                self.arrayOfMealIn = snapshot.documents.compactMap { document -> Meal? in // Specify the return type as Meal?
                    guard let name = document["name"] as? String,
                          let icon = document["icon"] as? String,
                          let productsData = document["products"] as? [[String: Any]] else {
                        print("Error in Meal initialization")
                        return Meal(id: "", name: "error", icon: "error", products: [])
                    }
                    
                    var products = productsData.compactMap { productData -> MealProduct? in
                        guard let countOfProduct = productData["countOfProduct"] as? Int,
                              let nameOfProduct = productData["nameOfProduct"] as? String else {
                            print("Error in MealProduct initialization")
                            return nil
                        }
                        
                        return MealProduct(countOfProduct: countOfProduct, nameOfProduct: nameOfProduct, haveOrNot: false)
                    }
                    print("11111 products")
                    products = self.checkDataToCook(productList: products)
                    print("333333 products")
                    return Meal(id: document.documentID, name: name, icon: icon, products: products)
                }
            }
        }
    }
    func addMeal(newMeal:Meal){
        if checkDataToAdd(newMeal: newMeal){
            let db = Firestore.firestore()
            
            var productsData = [[String: Any]]()
            
            for i in newMeal.products{
                let productData:[String:Any] = [
                    "countOfProduct": i.countOfProduct,
                    "nameOfProduct": i.nameOfProduct
                ]
                productsData.append(productData)
            }
            let mealData:[String:Any] = [
                "icon": newMeal.icon,
                "name": newMeal.name,
                "products": productsData
            ]
            db.collection("meal").addDocument(data: mealData)
        }else{
            print("??????error in menu_ViewModel in addMeal")
        }
        
        
    }
    func checkProduct(me:[MealProduct])->Bool{
        for i in me.indices{
            if me[i].haveOrNot == false{
                return false
            }
        }
        return true
    }
    
    
    private func checkDataToAdd(newMeal:Meal) -> Bool{
        guard !newMeal.name.isEmpty else{return false}
        guard !newMeal.icon.isEmpty else{return false}
        guard !newMeal.products.isEmpty else {return false}
        return true
    }
    
    
    private func checkDataToCook(productList: [MealProduct])->[MealProduct]{
        var newProductList = productList
        //MARK: getProducts
        getProductsToCheck{
            for i in newProductList.indices{
                
                if let index = self.arrayOfProducts.firstIndex(where: {$0.name == newProductList[i].nameOfProduct}){
                    if self.arrayOfProducts[index].count > newProductList[i].countOfProduct {
                        print("self.arrayOfProducts[index].count ==== \(self.arrayOfProducts[index].count)")
                        print("newProductList[i].countOfProduct === \(newProductList[i].countOfProduct)")
                        newProductList[i].haveOrNot = true
                    }else{
                        newProductList[i].haveOrNot = false
                    }
                }else{
                    newProductList[i].haveOrNot = false
                }
            }
            
        }
        print("2222222newProductList = \(newProductList)")
        return newProductList
        
    }
    private func getProductsToCheck(completion: @escaping () -> Void){
        self.arrayOfProducts = []
        let db = Firestore.firestore()
        
        db.collection("products").getDocuments{snapshot, error in
            if error == nil{
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        self.arrayOfProducts = snapshot.documents.map{i in
                            return Product(
                                id: i.documentID,
                                name: i["name"] as! String,
                                count: i["count"] as! Int,
                                price: i["price"] as! Double
                            )
                        }
                        completion()
                    }
                }
            }else{
                print("error in Menu_ViewModel in getProductsToCheck: \(String(describing: error))")
            }
        }
    }
    
    
    
    
}




