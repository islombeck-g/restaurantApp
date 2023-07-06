
import Foundation

enum positions{
    case cooker
    case cashier
}


struct Employeer:Identifiable{
    let id: String
    let name:String
    let phone:String
    let position:String
    let email:String
    let photoUrl:String?
    
    init(id: String, name: String, phone: String, position: String, email: String, photoUrl: String?) {
        self.id = id
        self.name = name
        self.phone = phone
        self.position = position
        self.email = email
        self.photoUrl = photoUrl
    }
}
