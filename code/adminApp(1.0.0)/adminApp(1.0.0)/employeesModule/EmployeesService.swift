import Foundation

final class EmployeesService{
    
    let employeesAPI = EmployeesAPI()
    
    func getData(completion: @escaping ([EmployeerStruct])-> Void){
        self.employeesAPI.get{ employees in
            completion(employees)
        }
    }
    
    
    
}
