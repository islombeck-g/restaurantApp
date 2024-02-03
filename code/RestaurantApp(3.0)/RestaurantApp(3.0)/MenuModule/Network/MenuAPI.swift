import Foundation
import UIKit
import FirebaseFirestore
import FirebaseStorage

final class MenuAPI {
    
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    
    func uploadPhoto(selectedImage: UIImage) {
        
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.8) else {return}
        
        let path = "mealImages/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        fileRef.putData(imageData) { metadata, error in
            
            if error == nil && metadata != nil {
                self.db.collection("mealImages").document().setData(["url": path])
            }
            
        }
    }
}
