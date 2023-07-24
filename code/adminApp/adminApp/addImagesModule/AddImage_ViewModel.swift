import Foundation
import SwiftUI
import FirebaseStorage
import FirebaseFirestore

class ContentView_ViewModel:ObservableObject{
    @Published var productImageCollection = [ImageStruct]()
    @Published var mealImageCollection = [ImageStruct]()
    @Published var selectedImage:UIImage?
    @Published var imageName:String = ""
    
    func addPhotoToDB(type: String){
        
        if type == "mealImages"{self.imageName = "1"}
        guard let selectedImage = self.selectedImage, !imageName.isEmpty else {
            print("No image or image name provided.")
            return
        }
        
        let storageRef = Storage.storage().reference()
        let imageData = self.selectedImage!.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else {
            print("Error converting image to data.")
            return
        }
        
        let path = "\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        let uploadTasl = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
                let db = Firestore.firestore()
                
                let data: [String:Any] = [
                    "name":self.imageName,
                    "url": path,
                    "type": type
                ]
                
                db.collection("images").addDocument(data: data) { error in
                    if error == nil {
                        DispatchQueue.main.async {
                            if type == "mealImages" {
//                                self.mealImageCollection.append(self.selectedImage!)
                                self.mealImageCollection.append(ImageStruct(image: self.selectedImage!, name: self.imageName, type: type, url: path))
                            } else{
//                                self.productImageCollection.append(self.selectedImage!)
                                self.productImageCollection.append(ImageStruct(image: self.selectedImage!, name: self.imageName, type: type, url: path))
                            }
                            self.imageName = ""
                            self.selectedImage = nil
                        }
                    } else {
                        print("error2: \(String(describing: error))")
                    }
                    
                }
                
            } else {
                print("error2: \(String(describing: error))")
            }
            
        }
    }
    
    
    func downloadPhotos() {
        let db =  Firestore.firestore()
        
        db.collection("images").getDocuments{ snapshot, error in
            if error == nil && snapshot != nil {

                var imagesData = [(String, String, String)]()
                
                for doc in snapshot!.documents {

                    if let name = doc["name"] as? String,
                       let url = doc["url"] as? String,
                       let type = doc["type"] as? String {
                        imagesData.append((name, url, type))
                    }
                    
                }
                for imageData in imagesData {
                    let (name, url, type) = imageData
                    
                    let storageRef = Storage.storage().reference().child(url)
                    
                    storageRef.getData(maxSize: 5*1024*1024) { data, error in
                        
                        if error == nil && data != nil {
                            
                            if let image = UIImage(data: data!){
                                
                                DispatchQueue.main.async {
                                    if type == "mealImages" {
                                        self.mealImageCollection.append(ImageStruct(image: image, name: name, type: type, url: url))

                                    } else {
                                        self.productImageCollection.append(ImageStruct(image: image, name: name, type: type, url: url))
                                    }
                                }
                            }
                        } else {
                            print("error: \(String(describing: error))")
                        }
                    }
                }
                
            } else {
                print("error: \(String(describing: error))")
            }
        }
    }
}


struct ImagePicker: UIViewControllerRepresentable{
    
    @EnvironmentObject var viewModel: ContentView_ViewModel
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
