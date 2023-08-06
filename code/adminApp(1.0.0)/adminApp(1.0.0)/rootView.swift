
import SwiftUI

struct rootView: View {
    
    @EnvironmentObject var authViewModel:AuthViewModel
    var body: some View {
        Group{
            if authViewModel.userSession != nil {
                MainModule()
                    .environmentObject(authViewModel)
//                ProfileView()
                    .transition(.slide)
//
            }else{
                LogInView()
                    .environmentObject(authViewModel)
                    .transition(.move(edge: .bottom))
            }
        }
    }
}

struct rootView_Previews: PreviewProvider {
    static var previews: some View {
        rootView()
            .environmentObject(AuthViewModel())
    }
}
