import SwiftUI

struct MainModule: View {
    @StateObject private var employeersViewMode = EmployeeViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        VStack{
            TabView{
                MenuView()
                    .tabItem{
                        Label("Menu", systemImage: "menucard")
                    }
                ProductsView()
                    .tabItem{
                        Label("Products", systemImage: "refrigerator")
                    }
                EmployeesView()
                    .environmentObject(self.employeersViewMode)
                    .tabItem{
                        Label("Employees", systemImage: "person.3")
                    }
                OrdersView()
                    .tabItem{
                        Label("Menu", systemImage: "menucard")
                    }
                ProfileView()
                    .environmentObject(authViewModel)
                    .tabItem {
                        Label("Profile", systemImage: "gear")
                    }
            }
        }
    }
}

struct MainModule_Previews: PreviewProvider {
    static var previews: some View {
        MainModule()
            .environmentObject(AuthViewModel())
    }
}
