import SwiftUI

struct ProductListView: View {
    
    let product: MarketProduct
    let which: whichViewModel
    var body: some View {
        
        ZStack  {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.white)
                .shadow(color: .gray, radius: 2.5)
            
            VStack {
                Image.getSafeImage(named: product.name)
                    .resizable()
                    .frame(width: 50, height: 50)
                
                Text(product.name)
                    .font(.custom("GillSans-Bold", size: 20))
                if self.which == .productViewModel {
                    Text("\(product.price.formatted())$")
                }
                
                
            }
        }
        .frame(minWidth: 108, maxWidth: 150)
        .frame(height: 140)
    }
}

#Preview {
    ProductsScreen()
        .environmentObject(ProductsViewModel(productsService: ProductsService.shared))
}
