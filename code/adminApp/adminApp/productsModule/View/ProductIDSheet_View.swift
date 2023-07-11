
import SwiftUI

struct ProductIDSheet_View: View {
    var product:Product
    var body: some View {
        VStack(alignment: .leading){
            Spacer()
                .frame(height: 40)
            Group{
                Text("Название продукта")
                    .font(.system(size: 15))
                Spacer()
                    .frame(height: 8)
                    HStack{
                        Text("\(product.name)")
                            .font(.system(size: 25))
                        Image(product.name)
                            .resizable()
                            .frame(width: 35, height: 35)
                }
                
                Divider()
            }
            Group{
                HStack{
                    Text("вес")
                    Text("\(product.count)")
                }
            }
            Spacer()
                .frame(height: 20)
            Group{
                HStack{
                    Text("Цена за 100 грамм: ")
                    Text("\(product.price.formatted())")
                        .foregroundColor(.blue)
                        .padding(.leading, -6)
                    Text("руб")
                }
            }
            Spacer()
                .frame(height: 15)
            Group{
                HStack{
                    Text("Цена за")
                    Text("\(product.count.formatted())")
                        .foregroundColor(.blue)
                    Text("грамм:")
                    let me:Double = Double(product.count) * product.price / 100
                    Text("\(me.formatted())")
                        .foregroundColor(.blue)
                    Text("руб")
                }
            }
            Spacer()
        }
        .padding(.leading, 25)
        .frame(maxWidth: .infinity, alignment: .leading)    
    }
}

//struct ProductIDSheet_View_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductIDSheet_View(product: Product(id: "", name: "картошка", count: 1000, price: 45))
//    }
//}
