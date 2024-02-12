import Foundation
import UIKit

final class MenuService {
    
    private var menuAPI: MenuAPI = MenuAPI()
    
    func addMealToAPI(dish: Dish, completion: @escaping(MenuErrors?) -> Void) {
        self.menuAPI.uploadPhoto(selectedImage: dish.image!) { result in
            guard result != nil else { return }
            let newDish = Dish(id: "", name: dish.name, price: dish.price, description: dish.description, imageUrls: result, stars: dish.stars, products: dish.products, gm: dish.gm, kcal: dish.kcal, category: dish.category)
            
            self.menuAPI.uploadDish(dish: newDish) { error in
                completion(error)
            }
        }
    }
    
    func getFullDishes(completion: @escaping([Dish]?, MenuErrors?) ->Void ) {
        
        self.menuAPI.getDishes { result, error in
            
            guard var dishArray = result else { completion(nil, error ?? .uncknownError); return }
            
            let dispatchGroup = DispatchGroup()
            
            for index in dishArray.indices {
                guard let imageURLs = dishArray[index].imageUrls else { continue }
                dispatchGroup.enter()
                self.menuAPI.loadImage(path: imageURLs) { image in
                    dishArray[index].image = image
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: .main) {
                // All images loaded
                completion(dishArray, nil)
            }
        }
    }
}

enum MenuErrors: String, CaseIterable {
    case imageDownloadError = "Error in downloading image\nTry later"
    case uncknownError = "Uncknown Error"
    case serverError = "Server error"
}
