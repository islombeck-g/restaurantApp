import SwiftUI

struct ProductMainId_View: View {
    let product:Product
    var body: some View {
        VStack{
            HStack{
                Text(product.name)
                Text("\(product.count) gr.")
                Spacer()
                    Image(product.name).resizable()
                        .frame(width: 50, height: 50)
            }
            HStack{
                Text("Цена за 100 грамм: ")
                Text("\(product.price.formatted())")
                    .foregroundColor(.blue)
                    .padding(.leading, -6)
                Text("руб")
                Spacer()
            }
            HStack{
                Text("Цена за")
                Text("\(product.count.formatted())")
                    .foregroundColor(.blue)
                Text("грамм:")
                let me:Double = Double(product.count) * product.price / 100
                Text("\(me.formatted())")
                    .foregroundColor(.blue)
                Text("руб")
                Spacer()
            }
        }
    }
}

//
//struct ProductMainId_View_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductMainId_View()
//    }
//}
