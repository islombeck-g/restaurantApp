import SwiftUI

struct OrderListItem: View {
    
    @Binding var product: Product
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.white)
                        .shadow(color: .gray, radius: 2.5)
                    
                    Image.getSafeImage(named: product.name)
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                .frame(minWidth: 78, maxWidth: 88)
                .frame(height: 100)

                
                Spacer()
                    .frame(width: 20)
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text(product.name)
                        .foregroundStyle(.black)
                        .styleMainText_25()
                    
                    HStack {
                        Button {
                            if product.count != 1 {
                                product.count -= 1
                            }
                        } label: {
                            Image(systemName: "minus.square.fill")
                                .font(.system(size: 35))
                                .foregroundStyle(.darkGreen)
                        }
                        
                        Text("\(product.count)")
                            .font(.custom("GillSans-Bold", size: 18))
                            .frame(width: 35)
                        
                        Button {
                            if product.count != 999 {
                                product.count += 1
                            }
                        } label: {
                            Image(systemName: "plus.square.fill")
                                .font(.system(size: 35))
                                .foregroundStyle(.darkGreen)
                        }
                        Spacer()
                        Text("\((product.price * Double(product.count)).formatted()) $")
                            .styleMainText_20()
                    }
                }
                Spacer()
            }

            Divider()
                .padding(.horizontal, 32)
        }
    }
}

#Preview {
    OrderListItem(product: .constant(Product(id: "", name: "Apple", price: 2.32, count: 20)))
}
