import Foundation

class MenuViewModel: ObservableObject {
    
    @Published var dishes: [Dish] = []
    @Published var ingredients: [Product] = []
    @Published var marketProducts: [MarketProduct] = []
    
    @Published var error:String?
    @Published var isLoading:Bool = false
    
    init(productsService: ProductsService) {
        self.productsService = productsService
        self.getMarketProducts()
    }
    private var productsService:ProductsService
    
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
    func addIngredient(productToAdd: Product) {
        if let index = ingredients.firstIndex(where: { product in
            product.id == productToAdd.id
        }) {
            ingredients[index].count += productToAdd.count
        } else {
            ingredients.append(productToAdd)
        }
    }
    func updateProductAfterChanging(product: Product) {
        if let index = ingredients.firstIndex(where: { product in
            product.id == product.id}) {
            ingredients[index] = product
        }
    }
    func removeFromChosenIngredients(removeProduct: Product) {
        self.ingredients.removeAll { product in
            removeProduct.id == product.id
        }
    } 
    func removeIngredients() {
        self.ingredients.removeAll()
    }
    
    func createDish() {
        
    }

}
