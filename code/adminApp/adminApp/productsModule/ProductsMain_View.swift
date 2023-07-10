
import SwiftUI

struct ProductsMain_View: View {
    @StateObject private var viewModel = Products_ViewModel()
    
    @State private var showProductAddSheet = false
    @State private var selectedProduct:Product? = nil
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing){
                List{
                    ForEach(viewModel.productsInWarehouse){product in
                        ProductIDList_View(product: product)
                            .onTapGesture {
                                self.selectedProduct = product
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
        .sheet(item: $selectedProduct, content:{ product in
            ProductIDSheet_View(product: self.viewModel.product)
                .presentationDetents([.medium])
        })
        .sheet(isPresented: self.$showProductAddSheet, content: { ProductAdd_View()
                .environmentObject(viewModel)
        })
        
    }
        
    init(){
        self.viewModel.get_Products()
    }
}

struct ProductsMain_View_Previews: PreviewProvider {
    static var previews: some View {
        ProductsMain_View()
    }
}
