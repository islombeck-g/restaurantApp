import Foundation

final class EmployeesService{
    
    let employeesAPI = EmployeesAPI()
    
    func getData(completion: @escaping ([EmployeerStruct])-> Void){
        self.employeesAPI.get{ employees in
            completion(employees)
        }
    }
    
    @MainActor
    func addToFirebase(employeer: EmployeerStruct, completion: @escaping (String)->Void){
        guard employeer.name != "" && employeer.email != "" && employeer.phone != "" && employeer.position != "" else{
            completion("error in decode data")
            return
        }
        self.employeesAPI.add(employeer: employeer) { result in
            completion(result)
        }
    }
    
    func deleteFromFirebase(employeerID: String, completion: @escaping (String)-> Void){
        guard employeerID != "" else {
            completion("employeer id is Empty")
            return
        }
        self.employeesAPI.delete(employeeID: employeerID) { result in
            completion(result)
        }
        
    }
    
}
