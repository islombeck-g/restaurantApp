import SwiftUI

struct ProductsScreen: View {
    
    @EnvironmentObject var viewModel: ProductsViewModel
    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 150))]
    var body: some View {
        NavigationStack {
            
            Group {
                
            }
            
            ScrollView {
                LazyVGrid(columns: columns, alignment:.center) {
                    ForEach(ConstProducts, id:\.self) { product in
                        ProductListView(product: product)
                            .padding(.vertical, 10)
                    }
                }
                .padding(.horizontal, 16)
                
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Plroducts")
                        .styleMainText()
                }
            }
        }
    }
}


#Preview {
    ProductsScreen()
        .environmentObject(ProductsViewModel())
}
