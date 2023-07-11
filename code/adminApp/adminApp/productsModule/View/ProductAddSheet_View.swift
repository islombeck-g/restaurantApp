
import SwiftUI

struct ProductAddSheet_View: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: Products_ViewModel
    @State private var isPresentingListOfProducts = false
    let range = stride(from: 100, through: 20000, by: 100)
    @State private var result:Double = ProductsArray[0].price
    @State private var derivedValue: Double = 100
    
    @State private var selectedProduct:Products = ProductsArray[0]
    
    @State private var selectedValue: Int = 100
    var body: some View {
        
        VStack(alignment: .leading){
            Spacer()
                .frame(height: 40)
            
            Group{
                Text("Название продукта")
                    .font(.system(size: 15))
                Spacer()
                    .frame(height: 8)
                
                Button{
                    isPresentingListOfProducts = true
                }label: {
                    HStack{
                        Text("\(selectedProduct.name)")
                            .font(.system(size: 25))
                        Image(selectedProduct.name)
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                    
                }
                
                Divider()
            }
            Group{
                HStack{
                    Text("вес")
                    Picker("Tip percentage", selection: $selectedValue) {
                
                                ForEach(Array(range), id: \.self) { me in
                                    Text("\(me.formatted()) грамм")
                                        .foregroundColor(.blue)
                                }
                            }
                    .onChange(of: selectedValue){newValue in
                        self.result = Double(newValue) * selectedProduct.price/100
                    }
                    .onChange(of: selectedProduct){newValue in
                        self.result = Double(self.selectedValue) * newValue.price/100
                    }
                            .pickerStyle(.inline)
                }
            }
            Spacer()
                .frame(height: 20)
            Group{
                HStack{
                    Text("Цена за 100 грамм: ")
                    Text("\(selectedProduct.price.formatted())")
                        .foregroundColor(.blue)
                        .padding(.leading, -6)
                    Text("руб")
                }
            }
            Spacer()
                .frame(height: 15)
            Group{
                HStack{
                    Text("Цена за")
                    Text("\(selectedValue.formatted())")
                        .foregroundColor(.blue)
                    Text("грамм:")
                    
                    Text("\(result.formatted())")
                        .foregroundColor(.blue)
                    Text("руб")
                }
                
            }
            
            Spacer()
                .frame(height: 70)
            HStack{
                Spacer()
                Button{
                    self.viewModel.addToBasket(product: Product(id: "", name: selectedProduct.name, count: self.selectedValue, price: selectedProduct.price))
                   dismiss()
                }label: {
                    Text("Добавить")
                }
                .buttonStyle(.bordered)
                Spacer()
                    .frame(width: 25)
            }
            
            Spacer()
            
            
        }
        
        .padding(.leading, 25)
        .frame(maxWidth: .infinity, alignment: .leading)
        .sheet(isPresented: $isPresentingListOfProducts) {
            ListOfProducts(selectedOption: $selectedProduct)
            
        }
        
    }
}


struct ProductAddSheet_View_Previews: PreviewProvider {
    static var previews: some View {
        ProductAddSheet_View()
    }
}


struct ListOfProducts: View {
    @Binding var selectedOption: Products
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        List{
            ForEach(ProductsArray, id: \.self){product in
                
                Button{
                    self.selectedOption = product
                    self.presentationMode.wrappedValue.dismiss()
                    
                }label: {
                    Label{
                        Text(product.name)
                    }icon: {
                        Image(product.name)
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                }
            }
        }
        
    }
}
