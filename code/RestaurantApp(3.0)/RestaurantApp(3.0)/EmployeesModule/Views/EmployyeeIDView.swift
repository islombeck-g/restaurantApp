import SwiftUI

struct EmployyeeIDView: View {
    
    @EnvironmentObject var viewModel:EmployeeViewModel
    var employee:EmployeeStruct
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            Spacer()
                .frame(height: 30)
           
            Image(employee.photoUrl ?? "user" )
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
                }
                .frame(maxWidth: .infinity, alignment: .leading)
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
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
           
            HStack{
                Spacer()
                
                Button{
                    viewModel.deleteEmployee(employeeID: employee.id)
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

#Preview {
    EmployyeeIDView(employee: EmployeeStruct(id: "", name: "testName", phone: "+7889348899", position: "cashier", email: "some@gmail.com", photoUrl: nil, bossEmail: "someBossEmail"))
        .environmentObject(EmployeeViewModel())
}
