import Foundation


final class AuthEmailViewModel : ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var rePassword = ""
    
    func signUp() -> Task<String, Error>{
        guard !self.email.isEmpty || !self.password.isEmpty || !self.rePassword.isEmpty else{
            print("no email or password")
            return Task { "no email or password" }
        }
        return Task{
            do{
                let returnedUserData = try await AuthManager.me.createUser(email:email, password: password)
                print("success")
                print(returnedUserData)
                return "success"
            }catch{
                print("error\(error)")
                return "error\(error)"
            }
        }
    }
    
    func signIn() -> Task<String, Error>{
        guard !self.email.isEmpty || !self.password.isEmpty else{
            print("no email or password")
            return Task { "no email or password" }
        }
        return Task{
            do{
                let returnedUserData = try await AuthManager.me.signInUser(email:email, password: password)
                print("success")
                print(returnedUserData)
                return "success"
            }catch{
                print("error\(error)")
                return "error\(error)"
            }
        }
    }
    
    
}



