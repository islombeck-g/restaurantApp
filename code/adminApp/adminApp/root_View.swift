

import SwiftUI

struct root_View: View {
    @State private var authView:Bool = false
    var body: some View {
        ZStack{
            NavigationStack{
//                Main_View(authView: $authView)
                Main_View()
            }
        }
        .onAppear{
            let authUser = try? AuthManager.me.auth_edUser()
            self.authView = authUser == nil
        }
        .fullScreenCover(isPresented: $authView){
            NavigationStack{
                Auth_View(authView: $authView)
            }
        }
      
    }
}

struct root_View_Previews: PreviewProvider {
    static var previews: some View {
        root_View()
    }
}
