import Foundation
import SwiftUI

struct ProductsInBasketListView: View {
    
    let products:[Product]
    
    var body: some View {
        HStack {
            
            Text("Basket \nproducts")
                .styleMainText_25()
            
            ScrollView(.horizontal) {
                HStack {
                    
                    ForEach(products, id: \.self) { product in
                        ZStack  {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.white)
                                .shadow(color: .gray, radius: 2.5)
                            
                            VStack {
                                Image.getSafeImage(named: product.name)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                
                                Text(product.name)
                                    .font(.custom("GillSans-Bold", size: 20))

                                Text("count: \(product.count)")
                                
                            }
                        }
                        .frame(minWidth: 98, maxWidth: 108)
                        .frame(height: 120)
                        .padding(.vertical)
                    }
                    
                }
                .padding(.leading, 10)
                
            }
            .scrollIndicators(.hidden)
            .background(Color.green.opacity(0.2))
            .clipShape(.rect(cornerRadius: 20))
            
        }
    }
}

#Preview {
    ProductsInBasketListView(products: con )
}


let con = [
    Product(
        id: "", name: "Apple", price: 0.99, count: 20),
    Product(
        id: "", name: "Banana", price: 0.79, count: 10),
    Product(
        id: "", name: "Egg", price: 0.19, count: 50),
    Product(
        id: "", name: "Peanut", price: 2.49, count: 5),
    Product(
        id: "", name: "Rice", price: 1.99, count: 8),
    Product(
        id: "", name: "Butter", price: 2.99, count: 3),
    Product(
        id: "", name: "Cheese", price: 3.99, count: 10)]
