
import SwiftUI

//struct Product:Identifiable{
//    let id: String?
//    let name:String
//    let count:Int
//    let price:Int
//
//}

struct ProductAdd_View: View {
    @State private var sheetView:Bool = false
    @EnvironmentObject var viewModel: Products_ViewModel

    var body: some View {
//        VStack{
            List{
                Section{
                    if !viewModel.productsInBasket.isEmpty{
                        ForEach(viewModel.productsInBasket, id: \.self){ pro in
                            Text(pro.name)
                            
                        }
                    }else{
                        Text("List of Products are Empty")
                    }
                }
                Section{
                    Button{
                        sheetView.toggle()
                    }label: {
                        HStack{
                            Spacer()
                            Text("addProduct")
                                .frame(alignment: .center)
                            Spacer()
                        }
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
