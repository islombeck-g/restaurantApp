import Foundation

class MenuViewModel: ObservableObject {
    
    @Published var dishes: [Dish] = []
    @Published var ingredients: [Product] = []
    @Published var marketProducts: [MarketProduct] = []
    @Published var chosedIngredients: [Product] = []
    
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
        if let index = chosedIngredients.firstIndex(where: { product in
            product.id == productToAdd.id
        }) {
            chosedIngredients[index].count += productToAdd.count
        } else {
            chosedIngredients.append(productToAdd)
        }
    }
    
    func removeFromChosenIngredients(removeProduct: Product) {
        self.chosedIngredients.removeAll { product in
            removeProduct.id == product.id
        }
    } 
    func removeIngredients() {
        self.chosedIngredients.removeAll()
    }

}
