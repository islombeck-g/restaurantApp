
import SwiftUI

struct rootView: View {
    
    @EnvironmentObject var authViewModel:AuthViewModel
    var body: some View {
        Group{
            if authViewModel.userSession != nil {
                ProfileView()
                    .transition(.slide)
                    .environmentObject(authViewModel)
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
    }
}
