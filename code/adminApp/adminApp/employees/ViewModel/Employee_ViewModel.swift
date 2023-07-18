
import Foundation
import FirebaseFirestore

final class Employees_ViewModel:ObservableObject{

    @Published var list = [Employeer]()
    @Published var name:String = ""
    @Published var phone:String = ""
    @Published var position:String = "cashier"
    @Published var email:String = ""
    
    func get(){
        let db = Firestore.firestore()
        db.collection("employees").getDocuments{snapshot, error in
            if error == nil{
               
                if let snapshot = snapshot{
                    DispatchQueue.main.async {
                        self.list =  snapshot.documents.map{ i in
                            
                            return Employeer(id: i.documentID, name: i["name"] as! String , phone: i["phone"] as! String , position: i["position"] as! String , email:i["email"] as! String, photoUrl: i["photo"] as? String)
                        }
                    }
                }
            }else{
                print("error in FirebaseClass_ load\(String(describing: error))")
            }
            
        }
        
    }
   
    func add(){
        guard name != "" && phone != "" && email != "" else {
            return
        }
        let db = Firestore.firestore()
        
        db.collection("employees").addDocument(data: ["name": self.name, "phone": self.phone, "position": self.position, "email": self.email, "photo": "defaultImage"]){ error in
            if error == nil{
                self.get()
            }else{
                print("error in addData \(String(describing: error))")
            }
            
        }
    }
    func delete(employeeID: String) {
        let db = Firestore.firestore()
        
        db.collection("employees").document(employeeID).delete { error in
            if let error = error {
                print("Error deleting document: \(error)")
            } else {
                print("Document successfully deleted!")
                self.get()
            }
        }
    }
}
