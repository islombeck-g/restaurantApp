import SwiftUI

struct ProductsScreen: View {
    
    @EnvironmentObject var viewModel: ProductsViewModel
    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 150))]
    var body: some View {
        NavigationStack {
            ScrollView {
                
                Group {
                    NavigationLink {} label: {
                        GoToNextViewButton()
                            .padding(.horizontal)
                    }
                }
                
                LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                    ForEach(ConstProducts, id:\.self) { product in
                        ProductListView(product: product)
                            .padding(.horizontal, 20)
                        
                    }
                }
            }
            .scrollIndicators(.hidden)
      
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Products")
                        .styleMainText()
                }
            }
        }
        .padding(.horizontal, 16)
    }
}


#Preview {
    ProductsScreen()
        .environmentObject(ProductsViewModel())
}
