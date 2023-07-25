import Foundation
import FirebaseStorage
import FirebaseFirestore


class ImageAPI {
    
    let db =  Firestore.firestore()
    
    func getData(completion: @escaping ([ImageStruct]) -> Void){
        var images = [ImageStruct]()
        var isFinished = false
        
        db.collection("images").getDocuments{ snapshot, error in
            guard error == nil else {
                
                print("error in ImageAPI in getData, error: \(String(describing: error))")
                completion([])
                return
            }
            guard let snapshot = snapshot else {
                print ("error in ImageAPI in getData, snapshot: \(String(describing: error))")
                completion([])
                return
            }
            DispatchQueue.main.async {
                print ("ImageAPI getData_start")
                var imagesData = [(String, String, String)]()
                
                for doc in snapshot.documents {
                    
                    if let name = doc["name"] as? String,
                       let url = doc["url"] as? String,
                       let type = doc["type"] as? String {
                        imagesData.append((name, url, type))
                    }
                    
                }
                print ("imagesData: \(imagesData)")
                for imageData in imagesData {
                    let (name, url, type) = imageData
                    
                    let storageRef = Storage.storage().reference().child(url)
                    
                    storageRef.getData(maxSize: 5*1024*1024) { data, error in
                        
                        if error == nil && data != nil {
                            
                            if let image = UIImage(data: data!){
                                
                                DispatchQueue.main.async {
                                    images.append(ImageStruct(image: image, name: name, type: type, url: url))
                                    if images.count == imagesData.count {
                                        isFinished = true
                                        completion (images)
                                    }
                                }
                            }
                        } else {
                            print("error: \(String(describing: error))")
                        }
                    }
                }
                print ("ImageAPI getData_end")
                if isFinished {
                    completion (images)
                }
            }
        }
        
    }
    
    func pushData(text: String, image:UIImage, type:String){
        
        let storageRef = Storage.storage().reference()
        let imageData = image.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else {
            print("error in ImageAPI in pushData converting image to data.")
            return
        }
        
        let path = "\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        let uploadTasl = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
                let db = Firestore.firestore()
                
                let data: [String:Any] = [
                    "name":text,
                    "url": path,
                    "type": type
                ]
                
                db.collection("images").addDocument(data: data) { error in
                    if error != nil {
                        print("error in ImageAPI in pushData: \(String(describing: error))")
                    }
                }
            } else {
                print("error in ImageAPI in pushData: \(String(describing: error))")
            }
            
        }
    }
    
}
