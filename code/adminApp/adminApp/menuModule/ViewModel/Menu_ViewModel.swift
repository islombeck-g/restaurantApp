
import Foundation
class Menu_ViewModel:ObservableObject{
    private var service = MealService()
    private var productService = ProductService()
    @Published var arrayOfMeal = [Meal]()
//    @Published var name = ""
//    @Published var icon = ""
    
    @Published var isLoading:Bool = false
    
    init(){
        self.getMeal()
    }
    
    func getMeal() {
        self.isLoading = true
        
        self.productService.getFromAPI { products in
            
            self.service.getFromAPI { meal in
                var updatedMeal = meal
                
                print("start check have or not")
                for mealItem in 0..<updatedMeal.count {
                    for mealItemProduct in 0..<updatedMeal[mealItem].products.count {
                        if let index = products.firstIndex(where: {
                            $0.name == updatedMeal[mealItem].products[mealItemProduct].nameOfProduct
                        }) {
                            if updatedMeal[mealItem].products[mealItemProduct].countOfProduct <= products[index].count {
                                var productCopy = updatedMeal[mealItem].products[mealItemProduct]
                                productCopy.haveOrNot = true
                                updatedMeal[mealItem].products[mealItemProduct] = productCopy
                                print("mealItemProduct.haveOrNot: \(mealItemProduct)")
                                print(updatedMeal)
                            }
                        }
                    }
                }
                print("end check have or not")
                self.arrayOfMeal = updatedMeal
                print("products: \(products)")
                print("meal: \(updatedMeal)")
            }
            self.isLoading = false
        }
    }

    func addMeal(newMeal: Meal){
        self.service.addToAPI(meal: newMeal)
        self.getMeal()
    }
    func deleteMeal(meal:Meal){
        self.service.deleteAPI(meal: meal)
        self.getMeal()
    }
}






