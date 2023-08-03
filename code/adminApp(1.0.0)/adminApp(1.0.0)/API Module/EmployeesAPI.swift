import Foundation
import FirebaseFirestore

final class EmployeesAPI {
    
    let db = Firestore.firestore()
    
    func get(completion: @escaping ([EmployeerStruct]) -> Void){
        db.collection("employees").getDocuments{snapshot, error in
            if error == nil{
                if let snapshot = snapshot{
                    var list = [EmployeerStruct]()
                    DispatchQueue.main.async {
                        list =  snapshot.documents.map{ i in
                            return EmployeerStruct(
                                id: i.documentID,
                                name: i["name"] as! String ,
                                phone: i["phone"] as! String ,
                                position: i["position"] as! String ,
                                email:i["email"] as! String,
                                photoUrl: i["photo"] as? String,
                                bossEmail: i["bossEmail"] as? String ?? "error in boss mail")
                        }
                        completion(list)
                    }
                }
            }else{
                print("error in FirebaseClass_ load\(String(describing: error))")
                completion([])
            }
            
        }
        
    }
    
    @MainActor
    func add(employeer: EmployeerStruct, completion: @escaping (String)-> Void){
        
        db.collection("employees").addDocument(data: [
            "name": employeer.name,
            "phone": employeer.phone,
            "position": employeer.position,
            "email": employeer.email,
            "photo": "defaultImage",
            "bossEmail": UserData().getUserEmail()]){ error in
            if error == nil{
                completion("Success")
            }else{
                completion("error in addData \(String(describing: error))")
            }
            
        }
    }
    
    func delete(employeeID: String, completion: @escaping(String)-> Void) {
        
        db.collection("employees").document(employeeID).delete { error in
            if let error = error {
                completion("Error deleting document: \(error)")
            } else {
                completion("Success")
            }
        }
    }
    
}
