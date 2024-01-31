import SwiftUI

struct ProductListView: View {
    
    let product: Products
    
    var body: some View {
        
        ZStack  {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.white)
                .shadow(color: .gray, radius: 2.5)
            
            VStack {
                GetSafeImage(named: product.name)
                    .resizable()
                    .frame(width: 50, height: 50)
                
                Text(product.name)
                    .font(.custom("GillSans-Bold", size: 20))
                Text("\(product.price.formatted())$")
                
            }
        }
        .frame(minWidth: 108, maxWidth: 150)
        .frame(height: 140)
    }
    
    func GetSafeImage(named: String) -> Image {
        let uiImage =  (UIImage(named: named) ?? UIImage(named: "unknown"))!
        return Image(uiImage: uiImage)
    }
}

#Preview {
    ProductsScreen()
        .environmentObject(ProductsViewModel())
}
