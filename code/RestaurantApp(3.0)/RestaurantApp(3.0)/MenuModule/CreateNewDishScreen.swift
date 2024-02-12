import SwiftUI
import PhotosUI

struct CreateNewDishScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: MenuViewModel
    @EnvironmentObject var customNavigation: CustomNavigationStack

    @State private var selectedPhoto: PhotosPickerItem?
    @State private var downloadedPhoto: UIImage?
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var gm: Double = 0
    @State private var kcal: Double = 0
    @State private var dishCategory: DishCategory = .beverage
    @State private var price: Double?
    
    var body: some View {
        NavigationStack {

            VStack {
                ScrollView {
                    
                    MenuListItemView(
                        picture: self.downloadedPhoto != nil ? self.downloadedPhoto! : UIImage(resource: .defaultDish),
                        stars: 4.2345,
                        description: $description,
                        name: $name)
                    .padding(.bottom)
                    
                    Divider()
                        .background(Color.green)
                    
                    PhotosPicker(selection: $selectedPhoto) {
                        Text("Chose image")
                            .styleOne()
                    }
                    CustomTextField(name: "Dish name", text: self.$name, isSecured: false)
                    CustomTextField(name: "Dish description", text: self.$description, isSecured: false)
  
                    if !self.viewModel.ingredients.isEmpty {
                        
                        ProductsInBasketListView(products: self.viewModel.ingredients, text: "Ingredients:")                            
                            .padding(.top, 15)
                    }
                    
                    NavigationLink {
                        IngredientsSearchScreen()
                    } label: {
                        Text("Chose ingredients")
                            .styleOne()
                    }
                    
                  
                    ZStack {
                        RoundedRectangle(cornerRadius: 15).stroke(Color("darkGreen"), lineWidth: 3)
                        VStack {
                            Slider(value: $gm, in: 1...5000, step: 1)
                                .padding()
                            Text("Gramm: \(gm.formatted())")
                                .styleMainText_20()
                                .padding(.bottom)
                        }
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15).stroke(Color("darkGreen"), lineWidth: 3)
                        VStack {
                            Slider(value: $kcal, in: 1...5000, step: 1)
                                .padding()
                            Text("Kcal: \(kcal.formatted())")
                                .styleMainText_20()
                                .padding(.bottom)
                        }
                    }
                    
                    TextField("Price", value: $price, format: .number)
                        .font(.custom("GillSans-Bold", size: 22))
                        .padding(.top)
                    Divider()
                    
                    DropDownView(menuActions: self.viewModel.allDishCategories, title: self.$dishCategory)
                    
//                    Picker("", selection: self.$dishCategory) {
//                        ForEach(DishCategory.allCases, id: \.self) {dishC in
//                            Text("\(dishC.rawValue)")
//                                .tag(dishC)
//                        }
//                    }
//                    .pickerStyle(.wheel)
                    
                    Button {
                        
                        let dish = Dish(id: "", name: self.name, price: self.price ?? 0.0, description: self.description, imageUrls: nil, stars: 0.0, products: self.viewModel.ingredients, gm: Int16(self.gm), kcal: Int16(self.kcal), category: self.dishCategory.rawValue, image: downloadedPhoto)
                        if self.viewModel.checkData(dish: dish) {
                            self.viewModel.createDish(dish: dish)
                            self.dismiss()
                            withAnimation {
                                self.customNavigation.showCustomTapbar = true
                            }
                        }
                    } label: {
                        Text("Create dish")
                            .styleOne()
                    }
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal, 16)
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Text("Create dish")
                        .styleMainText_30()
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        self.dismiss()
                        withAnimation {
                            self.customNavigation.showCustomTapbar = true
                        }
                        
                    } label: {
                        Image(systemName: "chevron.backward.circle.fill")
                            .foregroundStyle(Color("darkGreen"))
                    }
                    .padding()
                    .font(.system(size: 22))
                }
            }
            .navigationBarBackButtonHidden()
            
        }
        .onChange(of: selectedPhoto) { oldValue, newValue in
            Task {
                if let selectedPhoto,
                   let data = try? await selectedPhoto.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        downloadedPhoto = image
                    }
                }
                selectedPhoto = nil
            }
            
        }
        .onAppear {
            self.customNavigation.showCustomTapbar = false
        }
    }
}

#Preview {
    CreateNewDishScreen()
        .environmentObject(MenuViewModel())
        .environmentObject(CustomNavigationStack())
}
