import Foundation

enum positions{
    case cooker
    case cashier
}

struct EmployeerStruct:Identifiable{
    let id: String
    let name:String
    let phone:String
    let position:String
    let email:String
    let photoUrl:String?
    let bossEmail:String
    
   
}

