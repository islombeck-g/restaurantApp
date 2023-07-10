
import SwiftUI

struct ProductIDList_View: View {
    var product:Product
    var body: some View {
        HStack{
            Spacer()
                .frame(width: 20)
            VStack(alignment: .leading){
                Text(product.name)
                Text("\(product.count) gr.")
            }
            Spacer()
            VStack{
                Image(product.name).resizable()
                    .frame(width: 50, height: 50)
                
            }
            Spacer()
                .frame(width: 20)
        }
    }
}

struct ProductIDList_View_Previews: PreviewProvider {
    static var previews: some View {
        ProductIDList_View(product: Product(id: "", name: "картошка", count: 400, price: 21))
    }
}
