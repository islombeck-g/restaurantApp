import Foundation

final class AuthViewModel: ObservableObject {
    
    var userStateManager:UserManager
    init(userStateManager: UserManager) {
        self.userStateManager = userStateManager
    }
    
    @Published var isLoading = false
    //    MARK: AUTH
    @Published var email:String = ""
    @Published var name:String = ""
    @Published var password:String = ""
    @Published var repeadPassword:String = ""
    @Published var rememberUser:Bool = true
    @Published var errorMessage:String = ""
    
    func tryAuth() async {
        self.isLoading = true
        guard self.checkDataForAuth() else { self.isLoading = false; return }
        do {
            try await self.userStateManager.signIn(self.email, self.password)
        } catch {
            print("---error: \(error.localizedDescription)")
            errorMessage = error.localizedDescription
            self.isLoading = false
        }
        self.isLoading = false
    }
    
    func tryCreateNewUser() async {
        self.isLoading = true
        guard checkDataForCreateNewUser() else { isLoading = false; return }
        do {
            try await self.userStateManager.createUser(self.email, self.password, self.name)
        } catch {
            print("---error: \(error.localizedDescription)")
            self.isLoading = false
        }
        
        
        self.isLoading = false
    }
    private func checkDataForAuth() ->Bool {
        guard email.contains("@") else {
            self.errorMessage = "Email is uncorrect"
            return false}
        guard password.count > 7 else {
            self.errorMessage = "Password should have more than 7 characters!"
            return false
        }
        return true
    }
    private func checkDataForCreateNewUser() -> Bool {
        guard checkDataForAuth() else {return false}
        guard password == repeadPassword else { errorMessage = "Passwords are not same" ;return false }
        return true
    }
    
}
