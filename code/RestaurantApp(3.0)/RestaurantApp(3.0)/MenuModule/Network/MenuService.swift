import Foundation
import UIKit

final class MenuService {
    
    private var menuAPI: MenuAPI = MenuAPI()
    
    
    func addMealToAPI(dish: Dish, completion: @escaping(MenuErrors?) -> Void) {
        self.menuAPI.uploadPhoto(selectedImage: dish.image!) { result in
            guard result != nil else {
                return
            }
            let newDish = Dish(id: "", name: dish.name, price: dish.price, description: dish.description, imageUrls: result, stars: dish.stars, products: dish.products, gm: dish.gm, kcal: dish.kcal, category: dish.category)
            
            self.menuAPI.uploadDish(dish: newDish) { error in
                completion(error)
            }       
        }
    }
}

enum MenuErrors: String, CaseIterable {
    case imageDownloadError = "Error in downloading image\nTry later"
    
}
