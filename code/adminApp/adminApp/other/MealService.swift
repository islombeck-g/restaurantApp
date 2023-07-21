import Foundation

class MealService {
    
    var mealAPI = MealAPI()
    
    func getFromAPI (completion: @escaping ([Meal]) -> Void) {
        self.mealAPI.getData{meal in
//            print("meal: \(meal)")
            completion(meal)
        }
    }
    
    func addToAPI (meal:Meal) {
        guard meal.icon != "" && meal.name != "" &&  meal.products.count > 0 else {
            print ("error in MealService in addToAPI")
            return
        }
        self.mealAPI.pushData (meal: meal)
    }
    func deleteAPI (meal:Meal) {
        guard meal.icon != "" && meal.name != "" &&  meal.products.count > 0 else {
            print ("error in MealService in deleteAPI")
            return
        }
        self.mealAPI.deleteMeal (meal: meal)
    }
}
