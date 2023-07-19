import Foundation

class ProductService{
    
    var productAPI = ProductAPI()
    
    //MARK: let productService = ProductService()
//    productService.getFromAPI { products in
//        // Обработка полученных данных (products)
//        // Например, выведите на консоль или обновите ваш интерфейс с этими данными
//        print(products)
//    }
    func getFromAPI(completion: @escaping ([Product]) -> Void){
        self.productAPI.getData{ products in
            print("products: \(products)")
           completion(products)
        }
    }
    func addToAPI(product:Product){
        guard product.count > 0 && product.name != "" && product.price > 0 else{
            print("error in ProductService in addToAPI")
            return
        }
        self.productAPI.pushData(product: product)
    }
    func deleteAPI(product:Product){
        guard product.count > 0 && product.name != "" && product.price > 0 else{
            print("error in ProductService in deleteAPI")
            return
        }
        self.productAPI.deleteProduct(product: product)
    }
}
