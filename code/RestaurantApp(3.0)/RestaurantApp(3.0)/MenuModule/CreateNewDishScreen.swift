import SwiftUI
import PhotosUI

struct CreateNewDishScreen: View {
    
    @EnvironmentObject var viewModel: MenuViewModel
    //    @State private var dish = Dish(id: "", name: "", price: 0.0, products: [], imageUrls: [])
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var downloadedPhoto: UIImage?
    
    @State private var name: String = ""
    @State private var description: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                
                
                ScrollView {
                    
                    MenuListItemView(
                        picture: self.downloadedPhoto != nil ? self.downloadedPhoto! : UIImage(resource: .defaultDish),
                        stars: 4.2345,
                        description: $description,
                        name: $name)
                    
//                    MenuListItemView(picture: )
                    
                    PhotosPicker(selection: $selectedPhoto) {
                        Text("Chose image")
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
            }
            
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
    }
}

#Preview {
    CreateNewDishScreen()
        .environmentObject(MenuViewModel())
}
