import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var authViewModel:AuthViewModel
    @StateObject var employeeViewModel:EmployeeViewModel = EmployeeViewModel()
    @StateObject var productsViewMode:ProductsViewModel = ProductsViewModel()
    
    @StateObject var customNavigation: CustomNavigationStack = CustomNavigationStack()
    var body: some View {
//        if authViewModel.userStateManager.isLoggedIn {
        if (authViewModel.userStateManager.userSession != nil) {
            MainTapBarView()
                .environmentObject(employeeViewModel)
                .environmentObject(productsViewMode)
                .environmentObject(customNavigation)
        } else {
            IntroductionScreen()
        }
    }
}

#Preview {
    MainView()
        .environmentObject(AuthViewModel(userStateManager: UserManager.shared))
}
