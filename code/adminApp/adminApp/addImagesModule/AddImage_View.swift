import Foundation
import SwiftUI


struct AddImage_View: View {
    
    @StateObject var viewModel = AddImage_ViewModel()
    @State private var showSheet = false
    
    @State private var mealORproductImage = "productImage"
    
    var body: some View {
        NavigationStack{
            Spacer()
                .frame(height: 10)
            ScrollView {
                Spacer()
                    .frame(height: 60)
                
                if viewModel.selectedImage != nil {
                    Image(uiImage: viewModel.selectedImage!)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .shadow(radius: 6)
                        .frame(width: 320, height: 220)
                        .animation(.easeInOut(duration: 1.0))
                    
                }
                
                Spacer()
                HStack{
                    VStack{
                        if viewModel.selectedImage != nil {
                            
                            Picker(selection: self.$mealORproductImage, label: Text("select")){
                                Text("mealImages").tag("mealImages")
                                Text("productImages").tag("productImages")
                            }
                            
                            .frame(width: 180, height: 40)
                            .padding(.leading, 20)
                            .pickerStyle(.segmented)
                            .padding(.top, 8)
                            
                            if mealORproductImage == "productImages"{
                                TextField("Введите название продукта", text: self.$viewModel.imageName)
                                    .frame(width: 180, height: 40)
                                    .padding(.leading, 20)
                                    .padding(.top, 11)
                                    .textFieldStyle(.roundedBorder)
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                    VStack{
                        Button{
                            self.showSheet.toggle()
                        }label: {
                            Text("selectPhoto")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        
                        Button{
                            viewModel.addPhotoToDB(type: mealORproductImage)
                            print("button tapped")
                        }label: {
                            Text("uploadPhoto")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        .disabled(self.viewModel.uploadButtonIsActive(text: mealORproductImage))
                    }
                    
                }
                //            TextField("количество", value: $selectedCount, format: .number)
                if viewModel.imageName != "" {
                    TextField("Введите цену на продукт в рублях за 100 грамм", value: self.$viewModel.imagePrice, format:.number)
                        .padding(.leading, 20)
                        .padding(.top, 11)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                }
                
                Spacer()
                //            ScrollView{
                Section(content: {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: UIScreen.main.bounds.width/2-30))]) {
                        ForEach(self.viewModel.productImageCollection, id: \.self){i in
                            ImageCartView(image: i.image, text: i.name)
                        }
                    }
                    
                }, header: {
                    Text("products")
                    
                })
                Section(content: {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: UIScreen.main.bounds.width/2-30))]) {
                        ForEach(self.viewModel.mealImageCollection, id: \.self){i in
                            ImageCartView(image: i.image, text: i.name)
                        }
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
                
            }
            .ignoresSafeArea()
        }
        .refreshable {
            self.viewModel.downloadPhotos()
            
            self.viewModel.imageName = ""
            self.viewModel.imagePrice = 0
            self.viewModel.selectedImage = nil
            
            
        }
        
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
        }
        .frame(width: UIScreen.main.bounds.width/2-30, height: UIScreen.main.bounds.width/2-30)
        .padding()
        
    }
}
