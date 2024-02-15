import Foundation

class ProductsService: ObservableObject {
    
    @Published var ownProducts: [Product] = [Product]()
    @Published var marketProducts: [MarketProduct] = [MarketProduct]()
    @Published var error: String?
    
    let productAPI = ProductsAPI()
    
    init() {
        print("init_productService")
        self.getMarketProducts()
        self.getOwnProducts()
        
    }
    
    func getMarketProducts() {
        self.getMarketProducts { products, error in
            self.marketProducts = products ?? []
            self.error = error?.description
        }
    }
    
    func getOwnProducts() {
        self.getProducts { products, error in
            self.ownProducts = products ?? []
            self.error = error?.description
        }
    }
    
    func removeOwnProduct(product: Product) {
        self.error = self.productAPI.deleteProduct(product: product)?.description
    }
    
    private func getProducts(completion: @escaping([Product]?, ProductsAPIError?) -> Void ) {
        self.productAPI.get { products, error in
            completion(products, error)
        }
    }
    
    private func getMarketProducts(completion: @escaping([MarketProduct]?, ProductsAPIError?) -> Void) {
        self.productAPI.getMarketProducts { products, error in
         completion(products, error)
        }
    }
   
    func buyProduct(products: [Product]) {
        for product in products {
            self.productAPI.add(product: product)
        }
        self.getOwnProducts()
    }
}
