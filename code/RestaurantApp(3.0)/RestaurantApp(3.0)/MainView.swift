import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @StateObject var menuViewModel: MenuViewModel
    @StateObject var productsViewModel: ProductsViewModel
    @StateObject var employeeViewModel: EmployeeViewModel = EmployeeViewModel()
    @StateObject var customNavigation: CustomNavigationStack = CustomNavigationStack()
    
    init(productService: ProductsService) {
        _menuViewModel = StateObject(wrappedValue: MenuViewModel(productsService: productService))
        _productsViewModel = StateObject(wrappedValue: ProductsViewModel(productsService: productService))
    }

    var body: some View {
        //        if authViewModel.userStateManager.isLoggedIn {
        if (authViewModel.userStateManager.userSession != nil) {
            MainTapBarView()
                .environmentObject(employeeViewModel)
                .environmentObject(customNavigation)
                .environmentObject(productsViewModel)
                .environmentObject(menuViewModel)
            
        } else {
            IntroductionScreen()
        }
    }
}

//#Preview {
//    MainView(authViewModel: AuthViewModel(userStateManager: UserManager.shared), productService: ProductsService())
//        .environmentObject(AuthViewModel(userStateManager: UserManager.shared))
//}
