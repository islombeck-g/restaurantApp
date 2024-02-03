import Foundation

class ProductsViewModel:ObservableObject {
    
    @Published var products:[Product] = []
    @Published var basketProducts:[Product] = []
    @Published var marketProducts:[MarketProduct] = []
    
    @Published var error:String?
    @Published var isLoading:Bool = false
    
    init() {
        print("_______start getting Products for productViewModel")
        self.getProducts()
        self.getMarketProducts()
    }
    
//    MARK: Operations with Basket
    func addToBasket(productToAdd: Product) {
        if let index = basketProducts.firstIndex(where: { product in
            product.id == productToAdd.id
        }) {
            basketProducts[index].count += productToAdd.count
        } else {
            basketProducts.append(productToAdd)
        }
    }
    
    func removeFromBasket(removeProduct: Product) {
        self.basketProducts.removeAll { product in
            removeProduct.id == product.id
        }
    }
    func calculateBasketTotal() -> Double {
        basketProducts.reduce(0) { (sum, product) in
          sum + (product.price * Double(product.count))
        }
      }
    func removeBasket() {
        self.basketProducts.removeAll()
    }
    
    //    MARK: Product Service
    private var productsService = ProductsService()
    
    func getMarketProducts() {
        isLoading = true
        self.productsService.getMarketProducts { products, error in
            if products != nil {
                self.marketProducts = products!
            }
            self.error = error?.description
            self.isLoading = false
        }
    }
    
    func getProducts() {
        self.isLoading = true
        self.productsService.getProducts { products, error in
            if products != nil { self.products = products! }
            self.error = error?.description
            self.isLoading = false
        }
    }
    
    func buyProductsFromMarket() {
        
        guard self.basketProducts != [] else { return }
        
        for product in self.basketProducts {
            self.productsService.addProductToServer(product: product)
        }
    }
    
    func deleteProductFromServer(product: Product) {
        self.error =  self.productsService.deleteProductFromServer(product: product)?.description
        self.getProducts()
    }
}
