
import Foundation


final class MainViewModel:ObservableObject{
    
    
    
    func signOut()throws{
        try AuthManager.me.signOut()
    }
}
