import Foundation
import Firebase
import FirebaseFirestoreSwift


@MainActor
class AuthViewModel:ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var password1 = ""
    
    @Published var error:String?
    init(){
        self.userSession = Auth.auth().currentUser
        Task{
            await fetchUser()
        }
    }
    
    func signIn() async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession  = result.user
            await fetchUser()
        }
        catch {
            print("error in AuthViewModel in signIn: \(error.localizedDescription)")
        }
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
            await fetchUser()
        }
        catch {
            print("error in AuthViewModel in creatUser: \(error.localizedDescription)")
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        }
        catch{
            print("error in AuthViewModel in signOut: \(error.localizedDescription)")
        }
    }
    
    func deleteUser(){
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else{return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as:User.self)
        
        print("current user is: \(String(describing: self.currentUser))")
    }
    
}
