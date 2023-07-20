
import SwiftUI

struct AddMealSheet_View: View {
    @EnvironmentObject var viewModel: Menu_ViewModel
    @Environment(\.dismiss) var dismiss
    @State private var nameOfNewProduct:String = ""
    @State private var iconOfNewProduct:String = "defaultMealName"
    @State private var ingredients = [MealProduct]()
    @State private var showAddproductView = false
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                    .frame(height: 40)
                Image(iconOfNewProduct)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width/2.8, height: UIScreen.main.bounds.width/2.8)
                Spacer()
                    .frame(height: 20)
                
                NavigationLink(
                    destination:
                        ImageSelect_View(me: $iconOfNewProduct)
                    ,
                    label: {Text("Изменить картинку блюда")})
                Group{
                    
                    Spacer()
                        .frame(height: 30)
                    HStack{
                        Spacer()
                            .frame(width: 25)
                        Text("Название блюда:")
                        Spacer()
                    }
                    TextField("название блюда", text: self.$nameOfNewProduct)
                        .padding(.all, 20)
                    //                        .textFieldStyle(.roundedBorder)
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.nameOfNewProduct != "" ? Color.blue: Color.black, lineWidth: 2))
                        .padding(.horizontal, 20)
                }
                
                Group{
                    
                    Spacer()
                        .frame(height: 30)
                    HStack{
                        Spacer()
                            .frame(width: 25)
                        Text("Список продуктов:")
                        
                        Spacer()
                    }
                    List{
                        if self.ingredients.isEmpty{
                            Text("Ингредиентов пока нет")
                            
                        }else{
                            ForEach(ingredients, id:\.self) { ingredient in
                                HStack{
                                    Image(ingredient.nameOfProduct)
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                    Text(ingredient.nameOfProduct)
                                    Spacer()
                                    Text("\(ingredient.countOfProduct)гр.")
                                    Button{
                                        self.ingredients.remove(atOffsets:
                                                                    IndexSet(integer: ingredients.firstIndex(
                                                                        where: {$0.nameOfProduct == ingredient.nameOfProduct}
                                                                    )!))
                                    }label: {
                                        Image(systemName: "minus.circle")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                        
                    }
                    .listStyle(.inset)
                    HStack{
                        Button{
                            self.showAddproductView.toggle()
                        }label: {
                            Text("добавить ингредиент")
                        }.buttonStyle(.bordered)
                        
                        Button{
                            
                            let meal = Meal(id: "", name: nameOfNewProduct, icon: iconOfNewProduct, products: ingredients)
                            self.viewModel.addMeal(newMeal: meal)
                            
                            self.dismiss()
                        }label: {
                            Text("создать блюдо")
                        }.buttonStyle(.borderedProminent)
                        
                    }
                    
                }
                
                
                Spacer()
            }
            
        }
        .sheet(isPresented: self.$showAddproductView, content: {
            AddProductInNewMeal_View(arrayOfProduct: $ingredients)
                .presentationDetents([.medium])
        })
       
    }
    
}

struct AddMealSheet_View_Previews: PreviewProvider {
    static var previews: some View {
        AddMealSheet_View()
    }
}






//
//import SwiftUI
//
//struct AddMealSheet_View: View {
//    @EnvironmentObject var viewModel: Products_ViewModel
//    @State private var me:String = "d"
//    var body: some View {
//        VStack{
//            Spacer()
//                .frame(height: 40)
//            Image("defaultMealName")
//                .resizable()
//                .frame(width: UIScreen.main.bounds.width/2.8, height: UIScreen.main.bounds.width/2.8)
//                Spacer()
//                .frame(height: 20)
//
//            NavigationLink(
//                destination:
//                    ImageSelect_View(me: $me)
//                        .environmentObject(viewModel),
//                label: {Text("Изменить картинку блюда")})
//
//            Spacer()
//        }
//    }
//}
//
//struct AddMealSheet_View_Previews: PreviewProvider {
//    static var previews: some View {
//        AddMealSheet_View()
//    }
//}

