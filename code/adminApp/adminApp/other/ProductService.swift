import Foundation
import UIKit

class ProductService{
    
    var productAPI = ProductAPI()
    private let imageAPI = ImageAPI()
    
    //MARK: let productService = ProductService()
//    productService.getFromAPI { products in
//        // Обработка полученных данных (products)
//        // Например, выведите на консоль или обновите ваш интерфейс с этими данными
//        print(products)
//    }
    func getFromAPI(completion: @escaping ([Product]) -> Void){
        self.imageAPI.getData { imageArray in
            self.productAPI.getData{ products in
                
                var productReturnList = products
                for i in 0..<products.count{
                    if let index = imageArray.firstIndex(where: { $0.name == products[i].name }){
                        productReturnList[i].image = imageArray[index].image
                    }else{
                        productReturnList[i].image = UIImage(named: "errrorImage")
                    }
                }
                completion(productReturnList)
            }
        }
        
    }
    
    func addToAPI(product:Product){
        guard product.count > 0 && product.name != "" && product.price > 0 else{
            print("error in ProductService in addToAPI")
            return
        }
        self.productAPI.pushData(product: product)
    }
    
    func deleteAPI(product:Product, completion: @escaping (String) -> Void){
        guard product.count > 0 && product.name != "" && product.price > 0 else{
            print("error in ProductService in deleteAPI")
            completion("error in deleteApi in format")
            return
        }
        self.productAPI.deleteProduct(product: product){ text in
            
            completion(text)
        }
    }
    
    func getDataWithName(name: String, completion: @escaping (Product?)-> Void){
        self.productAPI.getDataWithName(name: name){products in
            completion (products)
        }
    }
    func getConstProducts(completion: @escaping ([ImageStruct])-> Void){
        self.imageAPI.getData { imageArray in
            var productList = [ImageStruct]()
            for i in imageArray{
                if i.type == "productImages"{
                    productList.append(i)
                }
            }
            completion(productList)
        }
    }
    
}
