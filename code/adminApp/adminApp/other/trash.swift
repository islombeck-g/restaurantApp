import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
        
    @Binding var selectedImage: UIImage?
    @Binding var showing:Bool
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker  
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(perent: self)
    }
    
}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var perent: ImagePicker
    init(perent: ImagePicker) {
        self.perent = perent
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("image selected")
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            DispatchQueue.main.async {
                self.perent.selectedImage = image
                
            }
            
            
            
        }
        self.perent.showing = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled")
    }
    
}




struct ContentView: View {
    @State private var showSheet = false
    @State private var selectedImage:UIImage?
    var body: some View {
    
        VStack {
            
        
            Group{
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            Spacer()
            if selectedImage != nil {
                Image(uiImage: selectedImage!)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            
            Spacer()
            
            Button{
                self.showSheet.toggle()
            }label: {
                Text("uploadPhoto")
            }
            
        }
        .padding()
        .sheet(isPresented: $showSheet){
            ImagePicker(selectedImage: $selectedImage, showing: $showSheet)        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


