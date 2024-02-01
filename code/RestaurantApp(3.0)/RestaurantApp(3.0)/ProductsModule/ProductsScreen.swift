import SwiftUI

struct ProductsScreen: View {
    
    @EnvironmentObject var viewModel: ProductsViewModel
    
    private var columns: [GridItem] = [ GridItem(.adaptive(minimum: 108)) ]
    
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
                        ForEach(ConstProducts, id:\.self) { product in
                            ProductListView(product: product)
                                .padding(.horizontal, 20)
                            
                        }
                    }
                   
                }
                Spacer()
                    .frame(height: 90)
           
            }
            .scrollIndicators(.hidden)
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Products")
                        .styleMainText()
                        .foregroundStyle(.darkGreen)
                }
            }
            .toolbar(.hidden, for: .tabBar)
        }
        .padding(.horizontal, 16)
    }
}


#Preview {
    ProductsScreen()
        .environmentObject(ProductsViewModel())
}
