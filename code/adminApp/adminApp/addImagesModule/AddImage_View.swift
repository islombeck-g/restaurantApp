import Foundation
import SwiftUI


struct AddImage_View: View {
    
    @StateObject var viewModel = ContentView_ViewModel()
    @State private var showSheet = false
    
    @State private var mealORproductImage = "productImage"
    
    var body: some View {
        
        ScrollView {
            
            Spacer()
                .frame(height: 60)
            
            if viewModel.selectedImage != nil {
                Image(uiImage: viewModel.selectedImage!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .shadow(radius: 6)
                
            }
            
            Spacer()
            
            Button{
                self.showSheet.toggle()
            }label: {
                Text("selectPhoto")
            }
            
            if viewModel.selectedImage != nil {
                
                Picker(selection: self.$mealORproductImage, label: Text("select")){
                    Text("mealImages").tag("mealImages")
                    Text("productImages").tag("productImages")
                }
                .pickerStyle(.segmented)
                
                if mealORproductImage == "productImages"{
                    TextField("Введите название продукта", text: self.$viewModel.imageName)
                }
               
           
                    Button{
                        viewModel.addPhotoToDB(type: mealORproductImage)
                        print("button tapped")
                    }label: {
                        Text("uploadPhoto")
                    }
                    .buttonStyle(.bordered)
                
                
                
                Spacer()
            }
            Spacer()
//            ScrollView{
                Section(content: {
                    ForEach(self.viewModel.productImageCollection, id: \.self){i in
                        ImageCartView(image: i.image, text: i.name)
//                        Image(uiImage: i.image)
//                            .resizable()
//                            .scaledToFit()
//                            .cornerRadius(10)
                        //                            .shadow(radius: 6)
                        //                            .frame(width: 320, height: 220)
                    }
                }, header: {
                    Text("products")
                    
                })
                Section(content: {
                    ForEach(self.viewModel.mealImageCollection, id: \.self){i in
                        ImageCartView(image: i.image, text: i.name)
//                        Image(uiImage: i.image)
//                            .resizable()
//                            .scaledToFit()
//                            .cornerRadius(10)
                        //                            .shadow(radius: 6)
                        //                            .frame(width: 320, height: 220)
                    }
                }, header: {
                    Text("meals")
                    
                })
                
//            }
        }
        .onAppear{
            self.viewModel.downloadPhotos()
        }
        .padding()
        .sheet(isPresented: $showSheet){
            ImagePicker(showing: $showSheet)
                .environmentObject(viewModel)
            
        }.ignoresSafeArea()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddImage_View()
    }
}


struct ImageCartView:View{
    let image:UIImage
    let padding: CGFloat = 10
    let text:String
    var body: some View{
        Group{
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .cornerRadius(8)
                .shadow(radius: 5)
                .overlay(alignment: .bottomTrailing) {
                    Text(text)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                }
        }.padding()
        
    }
}
