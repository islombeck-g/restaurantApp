
import SwiftUI

//struct Product:Identifiable{
//    let id: String?
//    let name:String
//    let count:Int
//    let price:Int
//
//}

struct ProductAdd_View: View {
    @Environment(\.dismiss) var dismiss
    @State private var sheetView:Bool = false
    @EnvironmentObject var viewModel: Products_ViewModel

    var body: some View {
//        VStack{
            List{
                Section{
                    if !viewModel.productsInBasket.isEmpty{
                        ForEach(viewModel.productsInBasket, id: \.self){ pro in
                            ProductIDList_View(product: pro)
                            
                        }
                    }else{
                        Text("Корзина пуста")
                            .frame(alignment: .center)
                    }
                }
                Section{
                    Button{
                        sheetView.toggle()
                    }label: {
                        HStack{
                            Spacer()
                            Text("Добавить продукт")
                                .frame(alignment: .center)
                            Spacer()
                        }
                    }
                }
                Section{
                    Button{
                        self.viewModel.addProductToDB(product: self.viewModel.productsInBasket){}
                        self.viewModel.progress()
                        dismiss()
                    }label:{
                        Text("сделать заказ на сумму: \(self.viewModel.countSumInBasket().formatted())")
                            .frame(alignment: .center)
                    }
                }
                
            }
            .onAppear{

            }
//        }
            .sheet(isPresented: $sheetView, content: {
                ProductAddSheet_View()
                    .environmentObject(viewModel)
            })
    }
}


struct ProductAdd_View_Previews: PreviewProvider {
    static var previews: some View {
        ProductAdd_View()
    }
}
