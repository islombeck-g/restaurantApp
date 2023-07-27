import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class AuthViewModel:ObservableObject {
    @Published var userSession :FirebaseAuth.User?
    @Published var currentUser: User?
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var password1 = ""
    
    @Published var error:String?
    init(){
        self.userSession = Auth.auth().currentUser
    }
    
    func signIn() async throws {
        print("signin")
    }
    
    func createUser() async throws{
        guard self.name != "" else {
            print("error in AuthViewModel in createUser поле name пустое!")
            self.error = "Поле имя должно быть заполнено"
            return
        }
        guard self.email != "" else {
            print("error in AuthViewModel in createUser поле email пустое!")
            self.error = "Поле email должно быть заполнено"
            return
        }
        guard self.password != "" && self.password1 != "" else {
            print("error in AuthViewModel in createUser поле password пустое!")
            self.error = "Поле паролей должны быть заполненны"
            return
        }
        guard self.password == self.password1 else{
            print("error in AuthViewModel in createUser password is not same!")
            self.error = "Пароли должны совпадать"
            return
        }
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, name: self.name, email: self.email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        }
        catch {
            print("error in AuthViewModel in creatUser: \(error.localizedDescription)")
        }
    }
    
    func deleteUser(){
        
    }
    
    
}
