import SwiftUI

struct ProductMarketScreen: View {

    @EnvironmentObject var viewModel: ProductsViewModel
    @Environment (\.dismiss) var dismiss
    
    @EnvironmentObject var customNavigation: CustomNavigationStack
    
    private var columns: [GridItem] = [ GridItem(.adaptive(minimum: 108)) ]
    @State private var selectedProduct:MarketProduct?
    @State private var showMakeOrderView:Bool = false
    var body: some View {
        NavigationStack {
            
            ZStack {
                ScrollView {
                    
                    if !self.viewModel.basketProducts.isEmpty {
                        
                        ProductsInBasketListView(products: self.viewModel.basketProducts)
                            .padding(.leading)
                            .padding(.top, 15)
                    }
                        
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
            }
            
            .sheet(item: self.$selectedProduct, content: { product in
                BuyCurrentProductView(product: product)
                    .presentationDetents([.height(620)])
            })
            .sheet(isPresented: self.$showMakeOrderView) {
                MakeOrderView()
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
        }
        .onAppear {
            self.customNavigation.showCustomTapbar = false
        }
    }
}

#Preview {
    ProductMarketScreen()
        .environmentObject(ProductsViewModel())
        .environmentObject(CustomNavigationStack())
}

