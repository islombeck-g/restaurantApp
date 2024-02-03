import SwiftUI

struct ProductInRestaurantListView: View {
    
    let product: Product
    
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
                Text("\(product.count) count")
                
            }
        }
        .frame(minWidth: 108, maxWidth: 150)
        .frame(height: 140)
    }
}

#Preview {
    ProductInRestaurantListView(product: Product(id: "", name: "Apple", price: 20, count: 11))
}
