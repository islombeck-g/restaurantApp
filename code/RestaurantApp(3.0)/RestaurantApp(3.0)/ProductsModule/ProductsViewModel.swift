import Foundation
import Combine

class ProductsViewModel:ObservableObject {
    
    @Published var products:[Product] = []
    @Published var basketProducts:[Product] = []
    @Published var marketProducts:[MarketProduct] = []
    
    @Published var error:String?
    @Published var isLoading:Bool = false
    
    init(productsService: ProductsService) {
        self.productsService = productsService
        self.productsService.$error.sink { [weak self] error in self?.error = error }.store(in: &cancellables)
        self.productsService.$ownProducts.sink { [weak self] ownProducts in self?.products = ownProducts }.store(in: &cancellables)
        self.productsService.$marketProducts.sink { [weak self] market in self?.marketProducts = market }.store(in: &cancellables)
    }
//    Это позволяет вам держать ссылку на подписку и отменять ее при необходимости (например, когда ProductsViewModel уничтожается, чтобы избежать утечек памяти).
    private var cancellables = Set<AnyCancellable>()
    
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
    private var productsService:ProductsService
    

    func updateOwnProducts(){
        productsService.getOwnProducts()
    }
    
    func buyProducts() {
        guard self.basketProducts != [] else { return }
        productsService.buyProduct(products: basketProducts)
        self.basketProducts = []
    }
    func removeOwmProduct(product: Product) {
        self.productsService.removeOwnProduct(product: product)
    }
}
