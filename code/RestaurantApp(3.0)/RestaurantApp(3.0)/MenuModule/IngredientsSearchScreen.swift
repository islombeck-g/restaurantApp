import SwiftUI

struct IngredientsSearchScreen: View {
    
    @EnvironmentObject private var viewModel: MenuViewModel
    
    @State private var selectedProduct:MarketProduct?
    
    private var columns: [GridItem] = [ GridItem(.adaptive(minimum: 108)) ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
               
                if !self.viewModel.chosedIngredients.isEmpty {
                    
                }
                
                ProductsInBasketListView(products: self.viewModel.chosedIngredients, text: "Ingredients:")
                    .padding(.leading)
                    .padding(.top, 15)
                
                LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                    ForEach(self.viewModel.marketProducts, id:\.self) { product in
                        ProductListView(product: product)
                            .padding(.horizontal, 20)
                            .onTapGesture {
                                self.selectedProduct = product
                            }
                    }
                }
                .padding(.top)
            }
            
            .sheet(item: self.$selectedProduct, content: { product in
                BuyCurrentProductView(which: .menuViewModel, product: product)
                    .presentationDetents([.height(620)])
            })
        }
    }
}

#Preview {
    IngredientsSearchScreen()
        .environmentObject(MenuViewModel(productsService: ProductsService.shared))
}
