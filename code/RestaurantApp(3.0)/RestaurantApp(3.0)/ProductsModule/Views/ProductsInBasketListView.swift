import Foundation
import SwiftUI

struct ProductsInBasketListView: View {
    
    @EnvironmentObject var menuViewModel: MenuViewModel
    
    let products:[Product]
    let text: String
    var onProductSelected: ((Int) -> Void)?
    let whichView:whichViewModel = .menuViewModel
    
    var body: some View {
        VStack {
            
            Text(text)
                .styleMainText_25()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                HStack {
                    
                    ForEach(products.indices, id: \.self) { index in
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.white)
                                .shadow(color: .gray, radius: 2.5)
                                .onTapGesture {
                                    // Вызывайте замыкание при нажатии на продукт
                                    onProductSelected?(index)
                                }
                            
                            VStack {
                                Image.getSafeImage(named: products[index].name)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                
                                Text(products[index].name)
                                    .font(.custom("GillSans-Bold", size: 20))
                                
                                
                                Text("count: \(products[index].count.formatted())")
                                    .foregroundStyle(whichView == .menuViewModel ? (menuViewModel.canCookOrNot(product: products[index]) ? Color.green: Color.red): .black)
//                                    .foregroundStyle(whichViewModel == .menuViewModel ? Color.red : Color.black)
                                
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

//#Preview {
//    ProductsInBasketListView(products: con, text: "Basket products")
//}


//let con = [
//    Product(
//        id: "", name: "Apple", price: 0.99, count: 20),
//    Product(
//        id: "", name: "Banana", price: 0.79, count: 10),
//    Product(
//        id: "", name: "Egg", price: 0.19, count: 50),
//    Product(
//        id: "", name: "Peanut", price: 2.49, count: 5),
//    Product(
//        id: "", name: "Rice", price: 1.99, count: 8),
//    Product(
//        id: "", name: "Butter", price: 2.99, count: 3),
//    Product(
//        id: "", name: "Cheese", price: 3.99, count: 10)]
