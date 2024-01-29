import FirebaseAuth
import FirebaseFirestore

final class UserManager: ObservableObject {
    
    static var shared = UserManager()
    @Published var currentUser: User?
    @Published var isLoading = false
    @Published var userSession: FirebaseAuth.User?
    @Published var isLoggedIn = false
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {await fetchUser()}
    }
    
    func signIn(_ email:String, _ password:String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            isLoggedIn = true
        } catch {
            print("error in auth in signIn: \(error.localizedDescription)")
            throw error
        }
    }
    
    func createUser(_ email:String, _ password:String, _ name:String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, name: name, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
            isLoggedIn = true
        } catch {
            print("error in createUser: \(error.localizedDescription)")
        }
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            isLoggedIn = false
            print("isLo\(isLoggedIn)")
        }
        catch {
            print("error in AuthViewModel in signOut: \(error.localizedDescription)")
        }
    }
    
    private func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else{return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as:User.self)
        
        print("current user is: \(String(describing: self.currentUser))")
    }
    
}

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
//    var image: String?

    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

//extension User {
//    static var Mock_user = User(id: NSUUID().uuidString, name: "test", email: "test@gmail.com")
//}
