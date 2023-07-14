
import SwiftUI

struct AddProductInNewMeal_View: View {
    @Environment(\.dismiss) var dismiss
    @Binding var arrayOfProduct:[MealProduct]
    @State private var selectedProduct = "картошка"
//    @State private var score = 0
    @State private var selectedCount:Int = Int()
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
            Group{
                TextField("количество", value: $selectedCount, format: .number)
//                    .keyboardType(.decimalPad)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(selectedCount == 0 ? Color.black: Color.blue, lineWidth: 2))
                    .padding()
            }

            
            if let result = isNumber(){
                switch result{
                    case "заполните данное wwwsdfполе":
                    Text(result)
                    case "не пусто":
                    Button{
                        let newProduct = MealProduct(countOfProduct: selectedCount, nameOfProduct: selectedProduct)
                        self.arrayOfProduct.append(newProduct)
                        self.dismiss()
                    }label: {
                        Text("добавить продукт")
                            .padding(.horizontal)
                    }
                    .buttonStyle(.borderedProminent)
                    default:
                    Text(result)
                }
            }else{
                Text("неопознанная ошибка")
            }
            
           
            Spacer()
        }
        .onDisappear{
            self.selectedProduct = "картошка"
            self.selectedCount = 0
        }
    }
    func isNumber()->String?{
        guard selectedCount != 0 else {return "количество должно быть не нулевым"}
        return "не пусто"
    }
}

struct AddProductInNewMeal_View_Previews: PreviewProvider {
    static var previews: some View {
        AddProductInNewMeal_View(arrayOfProduct: .constant(
            [MealProduct(countOfProduct: 100 , nameOfProduct: "булочка"),
             MealProduct(countOfProduct: 120 , nameOfProduct: "фарш")]))
    }
}
