import SwiftUI
import PhotosUI

struct CreateNewDishScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: MenuViewModel
    @EnvironmentObject var customNavigation: CustomNavigationStack
    //    @State private var dish = Dish(id: "", name: "", price: 0.0, products: [], imageUrls: [])
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var downloadedPhoto: UIImage?
    
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var gm: Double = 0
    @State private var kcal: Int16 = 0
    @State private var dishCategory: DishCategory = .breakfast
    
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
                    
                  
                    Slider(value: $gm, in: 1...5000, step: 3)
                    
                    
                    
                    Button {
                        self.viewModel.createDish()
                    } label: {
                        Text("Create dish")
                            .styleOne()
                    }
                    
                    
                }
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
        .environmentObject(MenuViewModel(productsService: ProductsService.shared))
        .environmentObject(CustomNavigationStack())
}
