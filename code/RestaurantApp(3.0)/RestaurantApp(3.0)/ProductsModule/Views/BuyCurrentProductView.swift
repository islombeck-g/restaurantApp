import SwiftUI

struct BuyCurrentProductView: View {
    
    @State private var countOfProduct = 1
    @EnvironmentObject var viewModel:ProductsViewModel
    @Environment(\.dismiss) var dismiss
    let product: MarketProduct
    
    let randomColor:Color = Color.random
    var body: some View {
        
        VStack {
            
                ZStack  {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.white)
                        .shadow(color: randomColor , radius: 100)
                    
                    
                    GetSafeImage(named: product.name)
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                }
                .frame(minWidth: 108, maxWidth: 150)
                .frame(height: 140)
                .padding(.top, 60)
            
                Text(product.name)
                    .styleMainText()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                    
            HStack {
                
                Text("Count of Product:")
                    .font(.custom("GillSans-Bold", size: 20))

                Spacer()
                
                Group {
                    
                    Button {
                        if self.countOfProduct != 1 {
                            self.countOfProduct -= 1
                        }
                    } label: {
                        Image(systemName: "minus.square.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(.darkGreen)
                    }
                   
                    Text("\(self.countOfProduct)")
                        .font(.custom("GillSans-Bold", size: 20))
                        .frame(width: 40)
                    
                    Button {
                        if self.countOfProduct != 999 {
                            self.countOfProduct += 1
                        }
                    } label: {
                        Image(systemName: "plus.square.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(.darkGreen)
                    }
                }
            }
            .padding(.top, 40)
            
            Group {
                
                Text("Unit Price: $\(self.product.price.formatted()) per item")
                    .font(.custom("GillSans-Bold", size: 20))
                    
                Text("Total Price for \(self.countOfProduct) Items: $\((self.product.price * Double(countOfProduct)).formatted())")
                    .font(.custom("GillSans-Bold", size: 20))
                    
            }
            .padding(.top, 40)
            .frame(height: 30)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                self.viewModel.addToBasket(productToAdd: Product(id: product.id, name: product.name, count: countOfProduct, price: product.price))
                self.dismiss()
            } label: {
                Text("Add to basket")
                    .styleOne()
            }
            .padding(.top, 40)
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 40)
        .padding(.horizontal, 16)
       
        
    }
    func GetSafeImage(named: String) -> Image {
        let uiImage =  (UIImage(named: named) ?? UIImage(named: "unknown"))!
        return Image(uiImage: uiImage)
    }
}

//#Preview {
//    BuyCurrentProductView(
//        product: MarketProduct(
//            id: "P001",
//            name: "Apple",
//            price: 0.99))
//            .environmentObject(ProductsViewModel())
//}

#Preview {
    ProductMarketScreen()
        .environmentObject(ProductsViewModel())
        .environmentObject(CustomNavigationStack())
}


extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
