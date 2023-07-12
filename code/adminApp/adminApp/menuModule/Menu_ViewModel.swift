
import Foundation
import FirebaseFirestore

class Menu_ViewModel:ObservableObject{
    
    @Published var arrayOfMealIn = [Meal]()
    
    func getMeal() {
        self.arrayOfMealIn = [] // Инициализация пустого массива
        let db = Firestore.firestore()
        db.collection("meal").getDocuments { snapshot, error in
            if let error = error {
                print("Error in Menu_ViewModel in getMeal(): \(error)") // Печать ошибки в случае её наличия
                return
            }
            
            guard let snapshot = snapshot else {
                print("Snapshot is nil") // Проверка наличия snapshot
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
                    
                    let products = productsData.compactMap { productData -> MealProduct? in
                        guard let countOfProduct = productData["countOfProduct"] as? Int,
                              let nameOfProduct = productData["nameOfProduct"] as? String else {
                            print("Error in MealProduct initialization")
                            return nil
                        }
                        
                        return MealProduct(countOfProduct: countOfProduct, nameOfProduct: nameOfProduct)
                    }
                    
                    return Meal(id: document.documentID, name: name, icon: icon, products: products)
                }
            }
        }
    }

    
    
    
}




