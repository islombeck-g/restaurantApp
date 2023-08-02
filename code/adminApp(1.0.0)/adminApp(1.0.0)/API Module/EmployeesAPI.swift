import Foundation
import FirebaseFirestore

final class EmployeesAPI {
    
    func get(completion: @escaping ([EmployeerStruct]) -> Void){
        let db = Firestore.firestore()
        db.collection("employees").getDocuments{snapshot, error in
            if error == nil{
                if let snapshot = snapshot{
                    var list = [EmployeerStruct]()
                    DispatchQueue.main.async {
                        list =  snapshot.documents.map{ i in
                            return EmployeerStruct(id: i.documentID, name: i["name"] as! String , phone: i["phone"] as! String , position: i["position"] as! String , email:i["email"] as! String, photoUrl: i["photo"] as? String, bossEmail: UserData().getUserEmail())
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
}
