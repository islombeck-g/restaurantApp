import SwiftUI

struct mainView: View {
    
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
    mainView()
        .environmentObject(AuthViewModel(userStateManager: UserManager.shared))
}
