
import SwiftUI

struct ProductsMain_View: View {
    @EnvironmentObject var viewModel:Products_ViewModel
    
    @State private var showProductAddSheet = false
    @State private var selectedProduct:Product? = nil
    @State private var showSomeView = false
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing){
                if self.viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                }else{
                    List{
                        if viewModel.productsInWarehouse.isEmpty{
                            Text("На складе закончились продукты :(")
                        }
                        ForEach(viewModel.productsInWarehouse){product in
                            ProductIDList_View(product: product)
//                            ProductMainId_View(product: product)  // я не понимаю, почему это место не работает(((((((((
                                .onTapGesture {
                                    self.selectedProduct = product
                                }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let productToDelete = viewModel.productsInWarehouse[index]
                                viewModel.deleteProductFromDB(product: productToDelete)
                            }
                        }
                    }
                    Button{
                        self.showProductAddSheet.toggle()
                    }label: {
                        Image(systemName: "plus")
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .font(.system(size: 25))
                            .cornerRadius(50)
                    }
                    .offset(x: -25, y: -10)
                }
            }
        }
        .sheet(isPresented: self.$showProductAddSheet, content: {
            ProductsAdd_View()
                .environmentObject(viewModel)
        })
        .sheet(item: $selectedProduct) { product in
            ProductIDSheet_View(product: product)
                .presentationDetents([.medium])
        }
    }
}

struct ProductsMain_View_Previews: PreviewProvider {
    static var previews: some View {
        ProductsMain_View()
    }
}
