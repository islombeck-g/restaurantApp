
import SwiftUI

struct MenuIdSheet_View: View {
    var meal: Meal
    var haveOfNot:Bool
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: UIScreen.main.bounds.width/2.5-20, height: UIScreen.main.bounds.width/2.5-30)
                    .foregroundColor(self.haveOfNot == true ? Color.green:Color.red)
                Image(meal.icon)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
                
            }

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
        }
       
//        .clipped() // Clip any overflowing content
    }
}

struct MenuIdSheet_View_Previews: PreviewProvider {
    static var previews: some View {
        MenuIdSheet_View(meal: Meal(id: "", name: "Гамбургер", icon: "гамбургер", products: [
            MealProduct(countOfProduct: 100 , nameOfProduct: "булочка", haveOrNot: true),
            MealProduct(countOfProduct: 120 , nameOfProduct: "фарш", haveOrNot: true),
            MealProduct(countOfProduct: 30 , nameOfProduct: "помидор", haveOrNot: false),
            MealProduct(countOfProduct: 10 , nameOfProduct: "капуста", haveOrNot: true),
            MealProduct(countOfProduct: 10 , nameOfProduct: "огурец", haveOrNot: true),
            MealProduct(countOfProduct: 10 , nameOfProduct: "майонез", haveOrNot: true),
            MealProduct(countOfProduct: 10 , nameOfProduct: "кетчуп", haveOrNot: true)
        ]), haveOfNot: false)
    }
}
