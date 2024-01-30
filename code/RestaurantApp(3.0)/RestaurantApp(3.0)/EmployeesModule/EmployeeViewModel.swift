import Foundation

class EmployeeViewModel: ObservableObject {
    
    @Published var employeeArray = [EmployeeStruct]()
    @Published var employeeToAdd:EmployeeStruct?
    
    @Published var error: String?
    
    let employeeService = EmployeesService()
    
    init() {
        self.getEmployees()
    }
    
    func getEmployees() {
        
        self.error = nil
        
        self.employeeService.getData { employees, error in
            if error != nil {
                self.error = error?.rawValue
            }
            if employees != nil {
                self.employeeArray = employees!
            }
        }
    }
    @MainActor
    func addEmployee() {
        self.error = nil
        guard let employee = employeeToAdd else { return }
        let res = self.employeeService.addToFirebase(employee: employee)
        if res != nil {
            self.error = res?.rawValue
            print("employee view model res of addEmployee \(String(describing: res))")
        }
        getEmployees()
    }
    
    func deleteEmployee(employeeID: String) {
        self.error = nil
        
        let res = self.employeeService.improveDeleteFromFirebase(employeeID: employeeID)
        
        if res != nil {
            self.error = res?.rawValue
        }
        
        getEmployees()
    }
}



let customEmployees = [
    EmployeeStruct(
        id: "1",
        name: "IslamIslamIslamIslamIslamIslam",
        phone: "79001239323",
        position: "cooker" ,
        email: "some@gmail.com",
        photoUrl: "user",
        bossEmail: "boss@gmail.com"),
    EmployeeStruct(
        id: "2",
        name: "Timur",
        phone: "79001239323",
        position: "cashier" ,
        email: "some@gmail.com",
        photoUrl: "user",
        bossEmail: "boss@gmail.com"),
    EmployeeStruct(
        id: "3",
        name: "Artur",
        phone: "79001239323",
        position: "cashier" ,
        email: "some@gmail.com",
        photoUrl: "user",
        bossEmail: "boss@gmail.com"),
    EmployeeStruct(
        id: "4",
        name: "Daniil",
        phone: "79001239323",
        position: "cooker" ,
        email: "some@gmail.com",
        photoUrl: "user",
        bossEmail: "boss@gmail.com"),
    EmployeeStruct(
        id: "5",
        name: "Ruslan",
        phone: "79001239323",
        position: "cashier" ,
        email: "some@gmail.com",
        photoUrl: "user",
        bossEmail: "boss@gmail.com"),
    EmployeeStruct(
        id: "6",
        name: "Rodion",
        phone: "79001239323",
        position: "cashier" ,
        email: "some@gmail.com",
        photoUrl: "user",
        bossEmail: "boss@gmail.com"),
    EmployeeStruct(
        id: "0",
        name: "Vlad",
        phone: "79001239323",
        position: "cashier" ,
        email: "some@gmail.com",
        photoUrl: "user",
        bossEmail: "boss@gmail.com")
    ]




//
//class EmployeeViewModel: ObservableObject {
//    
//    @Published var employeeArray = [EmployeeStruct]()
//    @Published var employeeToAdd:EmployeeStruct?
//    
//    @Published var error: String?
//    
//    let employeeService = EmployeesService()
//    
//    init() {
//        self.employeeArray = customEmployees
//    }
//    
//    func getEmployees() {
//        self.error = nil
//        self.employeeService.getData { employees in
//            self.employeeArray = employees
//        }
//    }
//    @MainActor
//    func addEmployee() {
//        self.error = nil
//        guard let employee = employeeToAdd else { return }
//        self.employeeService.addToFirebase(employee: employee) { result in
//            if result == "error in decode data"{
//                self.error = "Ошибка в заполнении"
//            }else if result != "Success" {
//                self.error = "Ошибка со стороны сервера"
//                print(result)
//            }else{
//                self.getEmployees()
//            }
//        }
//    }
//    
//    func deleteEmployee(employeeID: String) {
//        self.error = nil
//        
//        self.employeeService.deleteFromFirebase(employeeID: employeeID) { result in
//            
//            if result == "Success" { self.getEmployees() }
//            else if result != "employeer id is Empty" { self.error = result }
//            else { self.error = "Ошибка со стороны сервера" }
//            
//        }
//    }
//}
//
