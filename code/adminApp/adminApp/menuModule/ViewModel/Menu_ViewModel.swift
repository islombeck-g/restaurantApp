
import Foundation
class Menu_ViewModel:ObservableObject{
    private var service = MealService()
    private var productService = ProductService()
    @Published var arrayOfMeal = [Meal]()
    @Published var name = ""
    @Published var icon = ""
//    private var arrayOfProducts = [Product]()
    @Published var isloading:Bool = false
   
   
    init(){
        self.getMeal()
    }
    func getMeal(){
        self.isloading = true
        
        self.productService.getFromAPI{products in
            
            self.service.getFromAPI{meal in
                
                for i in meal{
                    for var j in i.products{
                        if let index = products.firstIndex(where: {$0.name == j.nameOfProduct}){
                            if j.countOfProduct <= products[index].count{
                                j.haveOrNot = true
                            }
                        }
                    }
                }
                self.arrayOfMeal = meal
              
            }
            self.isloading = false
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

    




