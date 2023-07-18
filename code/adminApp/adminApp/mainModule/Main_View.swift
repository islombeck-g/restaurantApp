
import SwiftUI

struct Main_View: View {
    //    @StateObject private var viewModel = MainViewModel()
    //    @Binding var authView:Bool
    @State private var path = NavigationPath()
    var body: some View {
        
        TabView {
            MenuMain_View()
                .tabItem{
                    Label("Menu", systemImage: "menucard")
                }
            ProductsMain_View()
                .tabItem{
                    Label("Products", systemImage: "refrigerator")
                }
            EmployeesMain_View()
                .tabItem{
                    Label("Employees", systemImage: "person.3")
                }
            OrdersMain_View()
                .tabItem{
                    Label("Orders", systemImage: "play.display")
                }
        }
        //        .tabViewStyle(PageTabViewStyle())
        
        
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
