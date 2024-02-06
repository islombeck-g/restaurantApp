import Foundation
import UIKit
import FirebaseFirestore
import FirebaseStorage

final class MenuAPI {
    
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    
    func uploadDish(dish: Dish, completion: @escaping(MenuErrors?) ->Void) {
        
            
            do {
                db.collection("Dish").addDocument(data: [
                    "name": dish.name,
                    "price": dish.price,
                    "description": dish.description!,
                    "imageUrls": dish.imageUrls![0],
                    "stars": dish.stars,
                    "products": dish.products,
                    "gm": dish.gm,
                    "kcal": dish.kcal,
                    "category": dish.category
                ])
                completion(nil)
                
            }
        
        
    }
    
    func uploadPhoto(selectedImage: UIImage, completion: @escaping(String?) -> Void) {
        
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.8) else { return }
        
        let path = "mealImages/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        fileRef.putData(imageData) { metadata, error in
            
            if error == nil && metadata != nil {
                self.db.collection("mealImages").document().setData(["url": path])
                completion(path)
            }
            
        }
    }
    
    
}
