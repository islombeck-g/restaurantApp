import Foundation
import UIKit

class ImageService{
    
    private var imageAPI = ImageAPI()
    
    func getFromAPI(completion: @escaping ([ImageStruct]) -> Void) {
        self.imageAPI.getData { result in
            completion(result)
        }
    }
    
    func addToAPI(text:String?, image: UIImage, type:String, price: Int){
       
        if type == "mealImages"{
            self.imageAPI.pushData(text: "1", image: image, type: type, price: 0)
        }else if type == "productImages"{
            guard text != "" && price >= 0 else{
                print("error in ImageService in addToAPI in ProductImage type, text is empty or price is under zero")
                return
            }
            self.imageAPI.pushData(text: text!, image: image, type: type, price: price)
        }else{
            print("error in ImageService in addToAPI NO-TYPE")
            return
        }
        
    }
    
    
}
