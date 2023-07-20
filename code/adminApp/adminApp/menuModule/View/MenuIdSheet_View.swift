
import SwiftUI

struct MenuIdSheet_View: View {
    @EnvironmentObject var viewModel:Menu_ViewModel
    @Environment(\.dismiss) var dismiss
    var meal: Meal

    
    var body: some View {
        
        VStack {
            HStack{
                Spacer()
                Button{
                    self.viewModel.deleteMeal(meal: meal)
                    self.dismiss()
                }label: {
                    Image(systemName: "minus.circle")
                        .foregroundColor(.red)
                        .font(.system(size: 25))

                    
                }
                Spacer()
                    .frame(width: 25)
            }
            Spacer()
                .frame(height: 20)
            Image(meal.icon)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width-50, height: 250)
                .cornerRadius(15)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(meal.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity) // Expand the width to fill the available space
                
                Divider()
                
                ScrollView { // Wrap the ForEach in a ScrollView to enable scrolling if necessary
                    VStack(alignment: .leading,spacing: 0) {
                        ForEach(meal.products, id: \.self) { product in
                            HStack{
                                Image(product.nameOfProduct)
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                
                                Text(product.nameOfProduct)
                                    .font(.headline)
                                    .foregroundColor(product.haveOrNot == true ? Color.black: Color.red)
                                Spacer()
                                Text("\(product.countOfProduct) гр")
                                    .foregroundColor(product.haveOrNot == true ? Color.black: Color.red)
                                
                            }
                            
                        }.listRowInsets(EdgeInsets())
                    }
                }
                
                Spacer()
                
            }
            .frame(width: UIScreen.main.bounds.width/1.3)
            
            
            HStack{
                
                
                Button{}label:{
                    Text("Изменить")
                        .foregroundColor(.red)
                        .frame(width: UIScreen.main.bounds.width/3)
                }
                .buttonStyle(.bordered)
                
                
                Button{}label:{
                    Text("Остановить")
                        .foregroundColor(.red)
                        .padding(.horizontal)
                        .frame(width: UIScreen.main.bounds.width/3)
                    
                }
                .buttonStyle(.bordered)
                
                
            }
            
        }
        
        
        
        
    }
}

struct MenuIdSheet_View_Previews: PreviewProvider {
    static var previews: some View {
        MenuIdSheet_View(meal: Meal(id: "", name: "Гамбургер", icon: "лапша", products: [
            MealProduct(countOfProduct: 100 , nameOfProduct: "булочка", haveOrNot: true),
            MealProduct(countOfProduct: 120 , nameOfProduct: "фарш", haveOrNot: true),
            MealProduct(countOfProduct: 30 , nameOfProduct: "помидор", haveOrNot: false),
            MealProduct(countOfProduct: 10 , nameOfProduct: "капуста", haveOrNot: true),
            MealProduct(countOfProduct: 10 , nameOfProduct: "огурец", haveOrNot: true),
            MealProduct(countOfProduct: 10 , nameOfProduct: "майонез", haveOrNot: true),
            MealProduct(countOfProduct: 10 , nameOfProduct: "кетчуп", haveOrNot: true)
        ]))
    }
}
