import Foundation

final class AuthViewModel: ObservableObject {
    @Published var isLoading = false
    //    MARK: AUTH
    @Published var email:String = ""
    @Published var password:String = ""
    
    func tryAuth() -> Bool{return true}
}
