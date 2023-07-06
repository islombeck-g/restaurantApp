
import SwiftUI

struct EmployeeIDSheet_View: View {
    @Environment(\.dismiss) var dismiss
    let employee:Employeer
    var viewModel: Employees_ViewModel
    var body: some View {
        
        VStack{
            Spacer()
                .frame(height: 30)
            Image(employee.photoUrl ?? "defaultImage" )
                .resizable()
                .frame(width: 80, height: 80)
            Spacer()
                .frame(height: 20)

                Group{
                    
                    Text("Name")
                        .font(.system(size: 12))
                    Spacer()
                        .frame(height: 8)
                    Text(employee.name)
                        .font(.system(size: 18))
                    Divider()
                    
                    Text("Email")
                        .font(.system(size: 12))
                    Spacer()
                        .frame(height: 8)
                    Text(employee.email)
                        .font(.system(size: 18))
                    Divider()
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
            Group{
                
                Text("Phone")
                    .font(.system(size: 12))
                Spacer()
                    .frame(height: 8)
                Text(employee.phone)
                    .font(.system(size: 18))
                Divider()
                
                Text("Position")
                    .font(.system(size: 12))
                Spacer()
                    .frame(height: 8)
                Text(employee.position)
                    .font(.system(size: 18))
                Divider()
               
                
                
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            HStack{
            Spacer()
                Button{
                    
                    viewModel.delete(employeeID: employee.id)
                    dismiss()
                }label: {
                    Text("delete account")
                        .foregroundColor(.red)
                }
                Spacer()
                    .frame(width: 25)
            }
            
            
            Spacer()
        }
    }
}

//struct EmployeeIDSheet_View_Previews: PreviewProvider {
//    static var previews: some View {
//        EmployeeIDSheet_View()
//    }
//}
