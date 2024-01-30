import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var authViewModel:AuthViewModel
    
    var body: some View {
        if authViewModel.userStateManager.isLoggedIn {
            MainTapBarView()
        } else {
            IntroductionScreen()
        }
    }
}

#Preview {
    MainView()
        .environmentObject(AuthViewModel(userStateManager: UserManager.shared))
}
