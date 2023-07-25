import Foundation
import SwiftUI
import FirebaseStorage
import FirebaseFirestore

class AddImage_ViewModel:ObservableObject{
    @Published var productImageCollection = [ImageStruct]()
    @Published var mealImageCollection = [ImageStruct]()
    @Published var selectedImage:UIImage?
    @Published var imageName:String = ""
    @Published var imagePrice:Int = Int()
    private var service = ImageService()
    

    func addPhotoToDB(type: String){
        guard selectedImage == selectedImage else{
            print("error in ")
            return}
        self.service.addToAPI(text: imageName, image: selectedImage!, type: type, price: imagePrice)
     DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.downloadPhotos()
         self.selectedImage = nil
         self.imageName = ""
         self.imagePrice = 0
        }
    }
    
    func downloadPhotos() {
        self.service.getFromAPI { downloadedData in
            self.productImageCollection = []
            self.mealImageCollection = []
            for data in downloadedData{
                if data.type == "mealImages"{
                    self.mealImageCollection.append(data)
                }else if data.type == "productImages"{
                    self.productImageCollection.append(data)
                }else{
                    print("some in Image_viewMdoel error document in downloaded data ")
                }
            }
        }
    }
    
    func uploadButtonIsActive(text:String)-> Bool{
        
        guard selectedImage != nil else{return true}
        if text == "mealImages"{
            return false
        }
        if self.imageName != "" {
            return false
        }
        return true
    }
}


struct ImagePicker: UIViewControllerRepresentable{
    
    @EnvironmentObject var viewModel: AddImage_ViewModel
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
                self.perent.viewModel.selectedImage = image
            }
        }
        self.perent.showing = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled")
        self.perent.showing = false
    }
    
}
