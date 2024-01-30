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
