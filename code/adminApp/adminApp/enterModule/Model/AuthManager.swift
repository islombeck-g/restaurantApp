import Foundation
import FirebaseAuth


struct authResultModel{
    let uid:String
    let email:String?
    let photoUrl:String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
    
}

final class AuthManager{
    static let me = AuthManager()
    private init(){}
    

    func auth_edUser() throws -> authResultModel{
        guard  let user = Auth.auth().currentUser else{
            throw URLError(.badServerResponse)
        }
        return authResultModel(user: user)
    }
    func createUser(email: String, password: String) async throws -> authResultModel{
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return authResultModel(user:authResult.user)
    }
    func signInUser(email:String, password:String) async throws -> authResultModel{
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return authResultModel(user:authResult.user)
    }
    
    func signOut() throws{
        try Auth.auth().signOut()
    }
}


