import SwiftUI

struct ProductMarketScreen: View {

    @EnvironmentObject var viewModel: ProductsViewModel
    @Environment (\.dismiss) var dismiss
    
    @EnvironmentObject var customNavigation: CustomNavigationStack
    
    private var columns: [GridItem] = [ GridItem(.adaptive(minimum: 108)) ]
    
    var body: some View {
        NavigationStack {
            ZStack {
               
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                        ForEach(ConstProducts, id:\.self) { product in
                            ProductListView(product: product)
                                .padding(.horizontal, 20)
                            
                        }
                    }
                }
            }
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

