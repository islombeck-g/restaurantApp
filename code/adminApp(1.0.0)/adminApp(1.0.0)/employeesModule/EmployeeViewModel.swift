import Foundation

class EmployeeViewModel:ObservableObject{
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var position: String = "cashier"
    @Published var error:String?
    
    private let employeesService = EmployeesService()
    
    @Published var employeesArray = [EmployeerStruct]()
    
    func getEmployees(){
        self.error = nil
        self.employeesService.getData { employees in
            self.employeesArray = employees
        }
    }
    
    @MainActor
    func addEmployee(){
        self.error = nil
        self.employeesService.addToFirebase(employeer: EmployeerStruct(id: "", name: self.name, phone: self.phone, position: self.position, email: self.email, photoUrl: "user", bossEmail: "")) { result in
            if result == "error in decode data"{
                self.error = "Ошибка в заполнении"
            }else if result != "Success" {
                self.error = "Ошибка со стороны сервера"
                print(result)
            }else{
                self.getEmployees()
            }
        }
    }
    
    func deleteEmployeer(employeerID: String){
        self.error = nil
        self.employeesService.deleteFromFirebase(employeerID: employeerID) { result in
            if result == "Success" {
                self.getEmployees()
            }else if result != "employeer id is Empty" {
                self.error = result
            }else {
                self.error = "Ошибка со стороны сервера"
            }
        }
    }
    
}
