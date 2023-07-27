import Foundation


struct User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    var image: String?
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User {
    static var Mock_user = User(id: NSUUID().uuidString, name: "test", email: "test@gmail.com")
}
