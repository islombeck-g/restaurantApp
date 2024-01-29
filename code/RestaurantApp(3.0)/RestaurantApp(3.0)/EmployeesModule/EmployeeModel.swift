import Foundation

struct EmployeeStruct:Identifiable{
    let id: String?
    let name:String
    let phone:String
    let position:String
    let email:String
    let photoUrl:String?
    let bossEmail:String
}
enum EmployeePositions {
    case cooker
    case cashier
}
