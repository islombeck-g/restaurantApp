
import SwiftUI

struct Main_View: View {
    @StateObject var productsViewModel: Products_ViewModel = Products_ViewModel()
    @StateObject var menuViewModel: Menu_ViewModel = Menu_ViewModel()

    var body: some View {
        TabView {
            MenuMain_View()
                .environmentObject(menuViewModel)
                .tabItem {
                    Label("Menu", systemImage: "menucard")
                }
            ProductsMain_View()
                .environmentObject(productsViewModel)
                .tabItem {
                    Label("Products", systemImage: "refrigerator")
                }
            EmployeesMain_View()
                .tabItem {
                    Label("Employees", systemImage: "person.3")
                }
            OrdersMain_View()
                .tabItem {
                    Label("Orders", systemImage: "play.display")
                }
        }
    }
}

struct main_View_Previews: PreviewProvider {
    @State static var me = true
    static var previews: some View {
        //        Main_View(authView: $me)
        Main_View()
    }
}
//List{
//    Button{
//        do{
//            try self.viewModel.signOut()
//            authView.toggle()
//        }catch{
//
//        }
//    }label: {
//        Text("logOut")
//    }
//}
//
