import SwiftUI

struct IngredientsSearchScreen: View {
    
    @EnvironmentObject private var viewModel: MenuViewModel
    @EnvironmentObject var customNavigation: CustomNavigationStack
    @Environment (\.dismiss) var dismiss
    
    @State private var selectedProduct:MarketProduct?
    @State private var showThisView:Bool = false
    
    private var columns: [GridItem] = [ GridItem(.adaptive(minimum: 108)) ]
    @State private var productToChange: Product?
    
    var body: some View {
        NavigationStack {
            ScrollView {
               
                if !self.viewModel.ingredients.isEmpty {
                    ProductsInBasketListView(products: self.viewModel.ingredients, text: "Ingredients:") { index in
                        productToChange = self.viewModel.ingredients[index]
                    }
                    .padding(.horizontal)
                }
                
                LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                    ForEach(self.viewModel.marketProducts, id:\.self) { product in
                        ProductListView(product: product, which: .menuViewModel)
                            .padding(.horizontal, 20)
                            .onTapGesture {
                                self.selectedProduct = product
                            }
                    }
                }
            }
            
            .sheet(item: self.$selectedProduct, content: { product in
                BuyCurrentProductView(which: .menuViewModel, product: product)
                    .presentationDetents([.height(620)])
            })
            .sheet(item: self.$productToChange, content: { productToChange in
                ChangeChosenProduct(which: .menuViewModel, product: productToChange)
            })
            
            
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        self.dismiss()
                        withAnimation {
                            self.customNavigation.showCustomTapbar = true
                        }
                    } label: {
                        Image(systemName: "chevron.backward.circle.fill")
                            .foregroundStyle(Color("darkGreen"))
                    }
                    .padding()
                    .font(.system(size: 22))
                }
                
                ToolbarItem(placement: .navigation) {
                    Text("Market")
                        .styleMainText_30()
                        .foregroundStyle(.darkGreen)
                }
                
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    IngredientsSearchScreen()
        .environmentObject(MenuViewModel())
        .environmentObject(CustomNavigationStack())
}
