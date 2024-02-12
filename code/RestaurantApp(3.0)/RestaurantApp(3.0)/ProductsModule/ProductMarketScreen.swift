import SwiftUI

struct ProductMarketScreen: View {

    @EnvironmentObject var viewModel: ProductsViewModel
    @Environment (\.dismiss) var dismiss
    
    @EnvironmentObject var customNavigation: CustomNavigationStack
    
    private var columns: [GridItem] = [ GridItem(.adaptive(minimum: 108)) ]
    @State private var selectedProduct:MarketProduct?
    @State private var showMakeOrderView:Bool = false
    
    @State private var productToChange: Product?
    
    var body: some View {
        NavigationStack {
                ScrollView {
                    
                    if !self.viewModel.basketProducts.isEmpty {
                        ProductsInBasketListView(products: self.viewModel.basketProducts, text: "Basket products") { index in
                            productToChange = self.viewModel.basketProducts[index]
                        }
                            .padding(.horizontal)
                            .padding(.top, 15)
                    }
                      
                    LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                        ForEach(self.viewModel.marketProducts, id:\.self) { product in
                            ProductListView(product: product, which: .productViewModel)
                                .padding(.horizontal, 20)
                                .onTapGesture {
                                    self.selectedProduct = product
                                }
                        }
                    }
                    .padding(.top)
                }
            
            .sheet(item: self.$selectedProduct, content: { product in
                BuyCurrentProductView(which: .productViewModel, product: product)
                    .presentationDetents([.height(620)])
            })
            .sheet(isPresented: self.$showMakeOrderView) {
                MakeOrderView()
            }
            .sheet(item: self.$productToChange) { productToChange in
                    ChangeChosenProduct(which: .productViewModel, product: productToChange)
                    .presentationDetents([.height(620)])
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        self.showMakeOrderView.toggle()
                    } label: {
                        Text("Make order")
                            .foregroundStyle(.white)
                            .padding(.all, 8)
                            .background(.darkGreen)
                            .clipShape(.rect(cornerRadius: 8))
                            
                    }
                    
                }
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
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .onAppear {
            withAnimation {
                self.customNavigation.showCustomTapbar = false
            }
        }
    }
}

#Preview {
    ProductMarketScreen()
        .environmentObject(ProductsViewModel())
        .environmentObject(CustomNavigationStack())
}

