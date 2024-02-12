import SwiftUI

struct ProductsScreen: View {
    
    @EnvironmentObject var viewModel: ProductsViewModel
    
    private var columns: [GridItem] = [ GridItem(.adaptive(minimum: 108)) ]
    
    @State private var detailProduct: Product?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                Group {
                    NavigationLink {
                        ProductMarketScreen()
                        
                    } label: {
                        GoToNextViewButton()
                            .padding(.horizontal)
                    }
                }
                
                if self.viewModel.products.isEmpty {
                    NoProductView()
                        .padding()
                } else {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                        ForEach(self.viewModel.products , id:\.self) { product in
                            ProductInRestaurantListView(product: product)
                                .padding(.horizontal, 20)
                                .onTapGesture {
                                    self.detailProduct = product
                                }
                            
                        }
                    }
                   
                }
                Spacer()
                    .frame(height: 90)
           
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 16)
            
            .refreshable {
                self.viewModel.getProducts()
            }
            
            .sheet(item: self.$detailProduct) { product in
                HomeProductDetailView(product: product)
                    .presentationDetents([.height(520)])
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Products")
                        .styleMainText_30()
                        .foregroundStyle(.darkGreen)
                }
            }
            .toolbar(.hidden, for: .tabBar)
        }
       
    }
}


#Preview {
    ProductsScreen()
        .environmentObject(ProductsViewModel())
}
