import Foundation

struct EmployeeStruct:Identifiable{
    let id: String?
    let name:String
    let phone:String
    let position:String
    let email:String
    let photoUrl:String?
    let bossEmail:String?
}
enum EmployeePositions:String, CaseIterable {
    case cooker
    case cashier
}
enum EmployeeAPIResults: String, CaseIterable{
    case success
    case idIsEmpty = "Id is empty"
    case serverError = "Server Error"
    case idEmpty = "Some Error"
    case userError = "Error from User"
}
