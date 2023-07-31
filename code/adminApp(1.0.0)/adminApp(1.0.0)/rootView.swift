
import SwiftUI

struct rootView: View {
    
    @EnvironmentObject var authViewModel:AuthViewModel
    var body: some View {
        Group{
            if authViewModel.userSession != nil {
                ProfileView()
                    .environmentObject(authViewModel)
            }else{
                LogInView()
                    .environmentObject(authViewModel)
            }
        }
    }
}

struct rootView_Previews: PreviewProvider {
    static var previews: some View {
        rootView()
    }
}
