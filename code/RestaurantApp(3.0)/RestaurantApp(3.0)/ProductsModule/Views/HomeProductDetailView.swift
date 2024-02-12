import SwiftUI

struct HomeProductDetailView: View {
    
    @EnvironmentObject var productViewModel: ProductsViewModel
    @Environment(\.dismiss) var dismiss
    @State var product: Product
    
    let randomColor: Color = Color.random
    let maxCount: Double
    
    init(product: Product) {
        self._product = State(initialValue: product)
        self.maxCount = product.count
    }
    
    var body: some View {
        VStack {
            ZStack  {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.white)
                    .shadow(color: randomColor , radius: 100)
                
                Image.getSafeImage(named: product.name)
                    .resizable()
                    .frame(width: 100, height: 100)
                
            }
            .frame(minWidth: 108, maxWidth: 150)
            .frame(height: 140)
            .padding(.top, 60)
            
            Text(product.name)
                .styleMainText_30()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
            
            HStack {
                
                Text("Count of Product:")
                    .font(.custom("GillSans-Bold", size: 20))
                
                Spacer()
                
                Group {
                    
                    Button {
                        if self.product.count != 0.1 {
                            product.count -= 0.1
                        }
                    } label: {
                        Image(systemName: "minus.square.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(.darkGreen)
                    }
                    
                    Text("\(self.product.count.formatted())")
                        .font(.custom("GillSans-Bold", size: 20))
                        .frame(width: 40)
                    
                    Button {
                        if self.product.count != maxCount {
                            self.product.count += 0.1
                        }
                    } label: {
                        Image(systemName: "plus.square.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(.darkGreen)
                    }
                }
            }
            .padding(.top, 20)
            
            Button {
                self.dismiss()
            } label: {
                Text("Save")
                    .styleOne()
            }
            .padding(.top, 20)
            
            Button {
                self.dismiss()
            } label: {
                Text("Remove product")
                    .padding()
                    .foregroundStyle(.red)
                    
            }
        }
//        .padding(.top, 40)
        .padding(.horizontal, 16)
    }
}

//#Preview {
//    HomeProductDetailView(product: Product(id: "", name: "Apple", price: 2.3, count: 10))
//        .environmentObject(ProductsViewModel())
//}
