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

    func improveDelete(employeeID: String) -> EmployeeAPIResults? {
        do {
            db.collection("employees").document(employeeID).delete()
            return nil
        }
    }
    
}
