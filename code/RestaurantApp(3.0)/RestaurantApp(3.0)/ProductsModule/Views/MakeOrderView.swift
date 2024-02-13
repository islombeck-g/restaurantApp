import SwiftUI

struct MakeOrderView: View {
    
    @EnvironmentObject var viewModel: ProductsViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {


            Spacer()
                .frame(height: 40)
            
            ForEach(self.viewModel.basketProducts.indices, id:\.self) { product in
                OrderListItem(product: self.$viewModel.basketProducts[product])
                    .padding(.horizontal, 20)
                    .listRowInsets(EdgeInsets())
            }

            Text("Total: \(self.viewModel.calculateBasketTotal().formatted()) $")
                .styleMainText_20()
            
            Button {
                self.dismiss()
                self.viewModel.buyProducts()
            } label: {
                Text("Make order")
                    .styleOneWithCustomFont()
                    .padding(.horizontal)
            }
            
            Button {
                self.dismiss()
                self.viewModel.removeBasket()
            } label: {
                Text("Clean basket")
                    .foregroundStyle(.red)
                    .styleMainText_20()
                    .padding(.horizontal)
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    MakeOrderView()
        .environmentObject(ProductsViewModel(productsService: ProductsService()))
}
