import Foundation
import FirebaseFirestore

final class EmployeeAPI {
    
    let db = Firestore.firestore()
    
    func get(completion: @escaping ([EmployeeStruct]?, EmployeeAPIResults?) -> Void) {
        
        db.collection("employees").getDocuments { snapshot, error in
            guard error == nil else {
                completion(nil, .serverError)
                return
            }
            
            var employees = [EmployeeStruct]()
            
            DispatchQueue.main.async {
                for document in snapshot!.documents {
                    let data = document.data()
                    let employee = EmployeeStruct(
                        id: document.documentID,
                        name: data["name"] as! String,
                        phone: data["phone"] as! String,
                        position: data["position"] as! String,
                        email: data["email"] as! String,
                        photoUrl: data["photo"] as? String,
                        bossEmail: data["bossEmail"] as? String ?? "error in boss mail"
                    )
                    employees.append(employee)
                }
                completion(employees, nil)
            }
        }
        
    }
    
    @MainActor
    func add(employee: EmployeeStruct) -> EmployeeAPIResults? {
        
        do {
            db.collection("employees").addDocument(data: [
                "name": employee.name,
                "phone": employee.phone,
                "position": employee.position,
                "email": employee.email,
                "photo": "defaultImage",
                "bossEmail": ShareUresData().getUserEmail()])
            return nil
        }
    }
    
//    func delete(employeeID: String, completion: @escaping(String)-> Void) {
//        
//        db.collection("employees").document(employeeID).delete { error in
//            if let error = error {
//                completion("Error deleting document: \(error)")
//            } else {
//                completion("Success")
//            }
//        }
//    }
    
    func improveDelete(employeeID: String) -> EmployeeAPIResults? {
        do {
            db.collection("employees").document(employeeID).delete()
            return nil
        }
    }
    
}

//import Foundation
//import FirebaseFirestore
//
//final class EmployeeAPI {
//
//    let db = Firestore.firestore()
//
//    func get(completion: @escaping ([EmployeeStruct]) -> Void){
//        db.collection("employees").getDocuments{snapshot, error in
//            if error == nil{
//                if let snapshot = snapshot{
//                    var list = [EmployeeStruct]()
//                    DispatchQueue.main.async {
//                        list =  snapshot.documents.map{ i in
//                            return EmployeeStruct(
//                                id: i.documentID,
//                                name: i["name"] as! String ,
//                                phone: i["phone"] as! String ,
//                                position: i["position"] as! String ,
//                                email:i["email"] as! String,
//                                photoUrl: i["photo"] as? String,
//                                bossEmail: i["bossEmail"] as? String ?? "error in boss mail")
//                        }
//                        completion(list)
//                    }
//                }
//            }else{
//                print("error in FirebaseClass_ load : \(String(describing: error))")
//                completion([])
//            }
//
//        }
//
//    }
//
//    @MainActor
//    func add(employee: EmployeeStruct, completion: @escaping (String)-> Void){
//
//        db.collection("employees").addDocument(data: [
//            "name": employee.name,
//            "phone": employee.phone,
//            "position": employee.position,
//            "email": employee.email,
//            "photo": "defaultImage",
//            "bossEmail": ShareUresData().getUserEmail()]){ error in
//                if error == nil{
//                    completion("Success")
//                }else{
//                    completion("error in addData \(String(describing: error))")
//                }
//
//            }
//    }
//
//    func delete(employeeID: String, completion: @escaping(String)-> Void) {
//
//        db.collection("employees").document(employeeID).delete { error in
//            if let error = error {
//                completion("Error deleting document: \(error)")
//            } else {
//                completion("Success")
//            }
//        }
//    }
//
//    func improveDelete(employeeID: String) -> EmployeeAPIResults {
//        do {
//            db.collection("employees").document(employeeID).delete()
//            return .success
//        }
//    }
//
//}
