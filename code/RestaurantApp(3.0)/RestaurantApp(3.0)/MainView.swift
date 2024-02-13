import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var authViewModel:AuthViewModel
    
    @EnvironmentObject var prodcutsService: ProductsService
    @StateObject var employeeViewModel:EmployeeViewModel = EmployeeViewModel()

    @StateObject var customNavigation: CustomNavigationStack = CustomNavigationStack()
    
    var body: some View {
//        if authViewModel.userStateManager.isLoggedIn {
        if (authViewModel.userStateManager.userSession != nil) {
            MainTapBarView()
                .environmentObject(employeeViewModel)
                .environmentObject(ProductsViewModel(productsService: prodcutsService))
                .environmentObject(MenuViewModel(productsService: prodcutsService))
                .environmentObject(customNavigation)
                
        } else {
            IntroductionScreen()
        }
    }
}

#Preview {
    MainView()
        .environmentObject(AuthViewModel(userStateManager: UserManager.shared))
        .environmentObject(ProductsService())
}
