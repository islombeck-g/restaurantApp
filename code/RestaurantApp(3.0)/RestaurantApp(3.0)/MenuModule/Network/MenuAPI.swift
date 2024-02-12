import Foundation
import UIKit
import FirebaseFirestore
import FirebaseStorage

final class MenuAPI {
    
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    
    func uploadDish(dish: Dish, completion: @escaping(MenuErrors?) ->Void) {
        do {
            let productsData = dish.products.map { product -> [String: Any] in
                return [
                    "id": product.id,
                    "name": product.name,
                    "price": product.price,
                    "count": product.count
                ]
            }

            db.collection("Dish").addDocument(data: [
                "name": dish.name,
                "price": dish.price,
                "description": dish.description ,
                "imageUrls": dish.imageUrls ?? "",
                "stars": dish.stars,
                "products": productsData,
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
    
    func getDishes(completion: @escaping([Dish]?, MenuErrors?) -> Void) {

        var dishes: [Dish] = [Dish]()
        
        db.collection("Dish").getDocuments { snapshot, error in

            guard error == nil else {
                print("--- DishError \(error!)")
                completion(nil, .serverError)
                return
            }

            DispatchQueue.main.async {
            
                dishes = snapshot!.documents.compactMap({ document -> Dish? in
                    
                    guard let name = document["name"] as? String,
                          let price = document["price"] as? Double,
                          let description = document["description"] as? String,
                          let stars = document["stars"] as? Double,
                          let gm = document["gm"] as? Int16,
                          let kcal = document["kcal"] as? Int16,
                          let category = document["category"] as? String,
                          let productsData = document["products"] as? [[String: Any]],
                          let imageUrls = document["imageUrls"] as? String
                    else {
                        print("snapsoht error")
                        print(snapshot?.documents ?? "someError")
                        print("______________")
                        return nil
                    }

                    let products = productsData.compactMap { productData -> Product? in
                        
                        guard let product_id = productData["id"] as? String,
                              let product_name = productData["name"] as? String,
                              let product_prica = productData["price"] as? Double,
                              let product_count = productData["count"] as? Double
                        else {
                            print("snapsoht error")
                            return nil
                        }
                        return Product(id: product_id, name: product_name, price: product_prica, count: product_count)
                    }
                    return Dish(id: document.documentID, name: name, price: price, description: description,imageUrls: imageUrls, stars: stars, products: products, gm: gm, kcal: kcal, category: category)
                })
                completion(dishes, nil)
            }
        }
    }
    
    func loadImage(path: String, completion: @escaping (UIImage?) -> Void) {
        
        let storageRef = Storage.storage().reference(withPath: path)
        
        storageRef.downloadURL { url, error in
            guard let url = url, error == nil else {
                print("Ошибка при получении URL-адреса изображения: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    print("Ошибка при загрузке изображения: \(error!.localizedDescription)")
                    completion(nil)
                    return
                }
                completion(image)
            }.resume()
        }
    }
}
