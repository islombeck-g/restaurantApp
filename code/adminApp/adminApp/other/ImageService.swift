import Foundation
import UIKit

class ImageService{
    
    private var imageAPI = ImageAPI()
    
    func getFromAPI(completion: @escaping ([ImageStruct]) -> Void) {
        self.imageAPI.getData { result in
            completion(result)
        }
    }
    
    func addToAPI(text:String?, image: UIImage, type:String){
       
        if type == "mealImages"{
            self.imageAPI.pushData(text: "1", image: image, type: type)
        }else if type == "productImages"{
            guard text != "" else{
                print("error in ImageService in addToAPI in ProductImage type, text is empty")
                return
            }
            self.imageAPI.pushData(text: text!, image: image, type: type)
        }else{
            print("error in ImageService in addToAPI NO-TYPE")
            return
        }
        
    }
    
    
}
