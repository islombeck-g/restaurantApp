
import SwiftUI

struct Auth_View: View {
    @State private var wichView = false
    @Binding var authView:Bool
    var body: some View {
        NavigationStack{
            ZStack{
                if wichView{
                    Registration_View(wichView: self.$wichView, authView: $authView)
                }else{
                    
                    LogIn_View(wichView: self.$wichView, authView: $authView)}
            }
        }
    }
}

struct Auth_View_Previews: PreviewProvider {
    static var previews: some View {
        Auth_View(authView: .constant(true))
    }
}
