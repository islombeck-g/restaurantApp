
import SwiftUI

struct EmployeeBanner_View: View {
    let employee:Employeer
    var body: some View {
        HStack{
            
            Image(employee.photoUrl ?? "default")
                .resizable()
                .frame(width: 50, height: 50)
            VStack{
                HStack{
                    Spacer()
                        .frame(width: 20)
                    Text(employee.name)
                    Spacer()
                    Divider()
                    Text(employee.position)
                }
                
                
            }
            
            
        }
    }
}

struct EmployeeBanner_View_Previews: PreviewProvider {
    static var previews: some View {
//        EmployeeBanner_View()
        EmployeesMain_View()
    }
}
