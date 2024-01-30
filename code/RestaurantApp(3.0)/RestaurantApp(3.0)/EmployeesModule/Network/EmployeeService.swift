import Foundation


final class EmployeesService {
    
    let employeesAPI = EmployeeAPI()
    
    func getData(completion: @escaping ([EmployeeStruct]?, EmployeeAPIResults?) -> Void) {
       
        self.employeesAPI.get { employees, error in
            completion(employees, error)
        }
    }
    
    @MainActor 
    func addToFirebase(employee: EmployeeStruct) -> EmployeeAPIResults? {
        guard employee.name != "" && employee.email != "" && employee.phone != "" && employee.position != "" else {
            return .userError
        }
        return self.employeesAPI.add(employee: employee)
    }
       
    func improveDeleteFromFirebase(employeeID: String) -> EmployeeAPIResults? {
        self.employeesAPI.improveDelete(employeeID: employeeID)
    }
    
}

//
//import Foundation
//
//
//final class EmployeesService {
//    
//    let employeesAPI = EmployeeAPI()
//    
//    func getData(completion: @escaping ([EmployeeStruct])-> Void) {
//        self.employeesAPI.get { employees in
//            completion(employees)
//        }
//    }
//    
//    @MainActor
//    func addToFirebase(employee: EmployeeStruct, completion: @escaping (String) -> Void) {
//        guard employee.name != "" && employee.email != "" && employee.phone != "" && employee.position != "" else {
//            completion("error in decode data")
//            return
//        }
//        self.employeesAPI.add(employee: employee) { result in
//            completion(result)
//        }
//    }
//    
//    func deleteFromFirebase(employeeID: String, completion: @escaping (String)-> Void) {
//        guard employeeID != "" else {
//            completion("employeer id is Empty")
//            return
//        }
//        self.employeesAPI.delete(employeeID: employeeID) { result in
//            completion(result)
//        }
//    }
//    
//    func improveDeleteFromFirebase(employeeID: String) -> EmployeeAPIResults {
//        guard employeeID.isEmpty else { return .idIsEmpty }
//        
//        return self.employeesAPI.improveDelete(employeeID: employeeID)
//    }
//    
//}
//
