import Foundation
import UIKit

class MenuViewModel: ObservableObject {
    
    @Published var dishes: [Dish] = []
    @Published var ingredients: [Product] = []
    @Published var marketProducts: [MarketProduct] = []
    
    @Published var error:String?
    @Published var isLoading:Bool = false
    let allDishCategories: [DishCategory] = [.appetizer, .soup, .salad, .mainCourse, .sideDish, .dessert, .beverage, .breakfast, .brunch, .sandwich, .pizza, .pasta, .seafood, .vegan, .glutenFree, .comfortFood, .international, .barbecue, .snack, .fusion, .some
    ]

    init() {
        self.getMarketProducts()
        print("self.getMarketProducts()")
    }
    private var productsService:ProductsService = ProductsService()
    
//    MARK: ingredients module
    func getMarketProducts() {
        isLoading = true
        self.productsService.getMarketProducts { products, error in
            if products != nil {
                self.marketProducts = products!
                print("marketProducts = \(self.marketProducts)")
            }
            self.error = error?.description
            self.isLoading = false
        }
    }
    func addIngredient(productToAdd: Product) {
        if let index = ingredients.firstIndex(where: { product in
            product.id == productToAdd.id
        }) {
            ingredients[index].count += productToAdd.count
        } else {
            ingredients.append(productToAdd)
        }
    }
    func updateProductAfterChanging(product: Product) {
        if let index = ingredients.firstIndex(where: { product in
            product.id == product.id}) {
            ingredients[index] = product
        }
    }
    func removeFromChosenIngredients(removeProduct: Product) {
        self.ingredients.removeAll { product in
            removeProduct.id == product.id
        }
    } 
    func removeIngredients() {
        self.ingredients.removeAll()
    }
    
//    MARK: work with service
    let dishService:MenuService = MenuService()
    
    func createDish(dish: Dish) {
        self.isLoading = true
        self.dishService.addMealToAPI(dish: dish) { error in
            self.error = error?.rawValue
            self.isLoading = false
        }
    }
    
    func checkData(dish: Dish) ->Bool {
        guard dish.name != "" || dish.name != " " else { return false }
        
        guard dish.price >= 0 else { return false }
        
        guard !dish.products.isEmpty else { return false }
        
        guard dish.gm > 0 else { return false }
        
        guard dish.kcal > 0 else { return false }
        
        guard dish.image != nil else { return false }
        
        return true
    }

}
