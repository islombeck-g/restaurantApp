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
                
                Text(product.name)
                    .font(.custom("GillSans-Bold", size: 30))
                Text("\(product.price.formatted())$")
                
            }
        }
        .frame(width: 150, height: 200)
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
