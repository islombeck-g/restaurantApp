import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var authViewModel:AuthViewModel
    
    @StateObject var employeeViewModel:EmployeeViewModel = EmployeeViewModel()
    @StateObject var productsViewMode:ProductsViewModel = ProductsViewModel()
//        productsService: ProductsService.shared)
    @StateObject var menuViewModel: MenuViewModel = MenuViewModel()
//        productsService: ProductsService.shared)

    @StateObject var customNavigation: CustomNavigationStack = CustomNavigationStack()
    
    var body: some View {
//        if authViewModel.userStateManager.isLoggedIn {
        if (authViewModel.userStateManager.userSession != nil) {
            MainTapBarView()
                .environmentObject(employeeViewModel)
                .environmentObject(productsViewMode)
                .environmentObject(menuViewModel) 
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
