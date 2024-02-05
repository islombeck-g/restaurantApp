import Foundation

class ProductsService {
    
    
    
    let productAPI = ProductsAPI()
    
    func getProducts(completion: @escaping([Product]?, ProductsAPIError?) -> Void ) {
        
        self.productAPI.get { products, error in
            completion(products, error)
        }
    }
    
    func getMarketProducts(completion: @escaping([MarketProduct]?, ProductsAPIError?) -> Void) {
        self.productAPI.getMarketProducts { products, error in
         completion(products, error)
        }
    }
    
    func deleteProductFromServer(product: Product) -> ProductsAPIError? {
        self.productAPI.deleteProduct(product: product)
    }
    
    func addProductToServer(product: Product) {
        self.productAPI.add(product: product)
    }
    
}
