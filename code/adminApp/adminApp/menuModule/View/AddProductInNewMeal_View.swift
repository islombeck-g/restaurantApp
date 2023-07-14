
import SwiftUI

struct AddProductInNewMeal_View: View {
    @Binding var arrayOfProduct:[MealProduct]
    @State private var selectedProduct = "картошка"
    @State private var selectedCount:Int = 0
    var body: some View {
        VStack{
            HStack{
                Picker("Название продукта", selection: $selectedProduct, content: {
                    ForEach(ProductsArray, id: \.self) { me in
                        HStack{
                            Image("\(me.name)")
                                .resizable()
                                .frame(width: 15, height: 15)
                            Text("\(me.name)")
                                .foregroundColor(.blue)
                            
                            Spacer()
                        }.tag("\(me.name)")
                    }})
                .pickerStyle(.inline)
                .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
                
                Image("\(self.selectedProduct)")
                
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
            }
            Text(selectedProduct)
            Spacer()
        }
    }
}

struct AddProductInNewMeal_View_Previews: PreviewProvider {
    static var previews: some View {
        AddProductInNewMeal_View(arrayOfProduct: .constant(
            [MealProduct(countOfProduct: 100 , nameOfProduct: "булочка"),
             MealProduct(countOfProduct: 120 , nameOfProduct: "фарш")]))
    }
}
