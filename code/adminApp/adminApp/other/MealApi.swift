

import Foundation
import FirebaseFirestore
class MealAPI{
    
    let db = Firestore.firestore()
    func getData(completion: @escaping ([Meal])->Void){
        var meal:[Meal] = [Meal]()
        
        db.collection("meal").getDocuments{snapshot, error in
            guard error == nil else{
                print ("error in MealApi in getData, error: \(String(describing: error))")
                completion([])
                return
            }
            guard let snapshot = snapshot else{
                print ("error ub MealApi in getData, snapshot: \(String(describing: error))")
                completion([])
                return
            }
            DispatchQueue.main.async {
                print ("mealApi getData_start")
                meal = snapshot.documents.compactMap{i -> Meal? in
                    guard let name = i["name"] as? String,
                          let icon = i["icon"] as? String,
                          let productsData = i["products"] as? [[String: Any]]
                    else{
                        print("error in MealApi in getData in snapshot")
                        return nil
                    }
                    //                    return MealProduct(countOfProduct: count, nameOfProduct: name, haveOrNot: self.checkProduct(name: name, count: count))
                    let products = productsData.compactMap{i -> MealProduct? in
                        
                        guard let name = i["name"] as? String,
                              let count = i["count"] as? Int
                        else{
                            print("error in MealApi in getData in snapshot")
                            return nil
                        }
                        
                        return MealProduct(countOfProduct: count, nameOfProduct: name, haveOrNot: false)
                        
                    }
                    return Meal(id: i.documentID, name: name, icon: icon, products: products)
                }
                
                print ("mealApi getData_end")
                completion(meal)
                
            }
        }
        
    }
    func pushData(meal:Meal){
        var mealProducts = [[String:Any]]()
        for i in meal.products{
            let me:[String:Any] = [
                "nameOfProduct": i.nameOfProduct,
                "countOfProduct": i.countOfProduct
            ]
            mealProducts.append(me)
        }
        let mealData:[String:Any] = [
            "name": meal.name,
            "icon": meal.icon,
            "products": mealProducts
        ]
        db.collection("meal").addDocument(data:mealData){error in
            guard error == nil else{
                print("error in MealApi in pushData: \(String(describing: error))")
                return
            }
        }
        
    }
    func deleteMeal(meal:Meal){
        db.collection("meal").document(meal.id).delete{ error in
            guard error == nil else{
                print ("error in MealApi in deleteMeal: \(String(describing: error))")
            return
            }
            print ("Meal successfully deleted!")
        }
    }
}
