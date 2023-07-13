import SwiftUI

struct MenuId_View: View {
    var meal: Meal
    
    var body: some View {
        HStack {
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: UIScreen.main.bounds.width/2.5-20, height: UIScreen.main.bounds.width/2.5-20)
                    .foregroundColor(.green)
                Image(meal.icon)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width/2.5, height: UIScreen.main.bounds.width/2.5)
                
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
                                    .frame(width: 15, height: 15)
                                Text(product.nameOfProduct)
                                    .font(.headline)
                                Spacer()
                                Text("\(product.countOfProduct) гр")
                            }
                            
                        }.listRowInsets(EdgeInsets())
                    }
                }
                
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width/2)
        }
        .frame(width: UIScreen.main.bounds.width - 50, height: 160)
        .clipped() // Clip any overflowing content
    }
}




struct MenuId_View_Previews: PreviewProvider {
    static var previews: some View {
        MenuId_View(meal: Meal(id: "", name: "Гамбургер", icon: "гамбургер", products: [
            MealProduct(countOfProduct: 100 , nameOfProduct: "булочка"),
            MealProduct(countOfProduct: 120 , nameOfProduct: "фарш"),
            MealProduct(countOfProduct: 30 , nameOfProduct: "помидор"),
            MealProduct(countOfProduct: 10 , nameOfProduct: "капуста"),
            MealProduct(countOfProduct: 10 , nameOfProduct: "огурец"),
            MealProduct(countOfProduct: 10 , nameOfProduct: "майонез"),
            MealProduct(countOfProduct: 10 , nameOfProduct: "кетчуп")
        ]))
    }
}


//
//struct MenuId_View: View {
//    var meal: Meal
//
//    var body: some View {
//        HStack {
//            Image(meal.icon)
//                .resizable()
//                .frame(width: UIScreen.main.bounds.width/2.5, height: UIScreen.main.bounds.width/2.5)
//
//            Spacer()
//
//            VStack(alignment: .leading) {
//                Text(meal.name)
//                    .font(.title)
//                    .multilineTextAlignment(.center)
//                    .frame(maxWidth: .infinity) // Expand the width to fill the available space
//
//                Spacer()
//
//                ScrollView { // Wrap the ForEach in a ScrollView to enable scrolling if necessary
//                    VStack(alignment: .leading,spacing: 0) {
//                        ForEach(meal.products, id: \.self) { product in
//                            HStack{
//                                Text(product.nameOfProduct)
//                                    .frame(alignment: .leading)
//                                Image(product.nameOfProduct)
//                                    .resizable()
//                                    .frame(width: 15, height: 15)
//                                Text("\(product.countOfProduct)")
//                            }
//
//                        }.listRowInsets(EdgeInsets())
//                    }
//                }
//
//                Spacer()
//            }
//            .frame(width: UIScreen.main.bounds.width/2)
//        }
//        .frame(width: UIScreen.main.bounds.width - 50, height: 160)
//        .clipped() // Clip any overflowing content
//    }
//}
