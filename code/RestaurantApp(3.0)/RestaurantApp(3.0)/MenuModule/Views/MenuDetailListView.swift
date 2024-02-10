import SwiftUI
import PhotosUI

struct MenuDetailListView: View {
    
    @EnvironmentObject var viewModel: MenuViewModel
    
    @Binding var dish: Dish
    
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var gm: Double
    @State private var kcal: Double
    
    init(dish: Binding<Dish>) {
            self._dish = dish
            _gm = State(initialValue: Double(dish.wrappedValue.gm))
            _kcal = State(initialValue: Double(dish.wrappedValue.kcal))
        }
    
    var body: some View {
        VStack {
            ZStack {
                Image("defaultDish")
                    .resizable()
                    .scaledToFill()
                    .frame(height: self.dish.isExpanded ? 250 : 100)
                    .clipped()
                
                
                if !self.dish.isExpanded {
                    Group {
                        HStack {
                            Image(systemName: "star.fill")
                            Text(String(format: "%.2f", dish.stars))
                                .styleMainText_15_black()
                                .bold()
                        }
                    }
                    .foregroundStyle(.white)
                    .font(.system(size: 12))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.leading, 16)
                    .padding(.bottom, 8)
                }
                
            }
            if !self.dish.isExpanded {
                Group {
                    Text(dish.name)
                        .styleMainText_20_black()
                        .lineLimit(1)
                    Text(dish.description)
                        .styleMainText_15_black()
                        .lineLimit(dish.isExpanded ? 10: 1)
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            if self.dish.isExpanded {
                
                Text(dish.name)
                    .styleMainText_30()
                
                HStack {
                    ForEach(1..<6, id:\.self) { number in
                        Image(systemName: "star.fill")
                            .foregroundStyle(dish.stars > Double(number) ? Color.yellow : Color.gray)
                    }
                }
                Text("\(dish.price.formatted()) $")
                    .styleMainText_25()
                
                Text(dish.description)
                    .styleMainText_20()
                    .padding(.top, 15)
                
                
            }
            
            Spacer()
        }
        .background(.thickMaterial)
        .clipShape(.rect(cornerRadius: self.dish.isExpanded ? 0 : 10))
        .onChange(of: selectedPhoto) { oldValue, newValue in
            Task {
                if let selectedPhoto,
                   let data = try? await selectedPhoto.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        dish.image = image
                    }
                }
                selectedPhoto = nil
            }
            
        }
//        .frame(maxHeight: .infinity, alignment: .top)
        //        .frame(height: self.dish.isExpanded ? (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.screen.scale : 100)
    }
}



#Preview {
    MenuDetailListView(dish: .constant(Dish(id: "", name: "Tea", price: 5.0, description: "sdfaodnsfoadnfoadnfasd afojnds faijn dskjf nasdj ifnasdifn aisdnf iasdjn fiadjsn ifadn", stars: 3.4, products: [Product(id: "", name: "Tea", price: 3, count: 1)], gm: 200, kcal: 12, category: "Beverage", isExpanded: false)))
        .environmentObject(MenuViewModel())
}
