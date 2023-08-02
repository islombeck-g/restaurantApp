import SwiftUI

struct MainModule: View {
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
                     .tabItem{
                         Label("Employees", systemImage: "person.3")
                     }
                OrdersView()
                     .tabItem{
                         Label("Menu", systemImage: "menucard")
                     }
            }
        }
    }
}

struct MainModule_Previews: PreviewProvider {
    static var previews: some View {
        MainModule()
    }
}
