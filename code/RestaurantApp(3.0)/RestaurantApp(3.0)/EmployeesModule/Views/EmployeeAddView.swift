import SwiftUI

struct EmployeeAddView: View {
    
    @EnvironmentObject var viewModel: EmployeeViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var name:String = ""
    @State private var email:String = ""
    @State private var phone:String = ""
    @State private var position:EmployeePositions = EmployeePositions.cashier
    var body: some View {
        VStack {
            TextField ("Name", text: self.$name)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(self.name != "" ? Color("darkGreen"): .gray, lineWidth: 2) )
            TextField ("email", text: self.$email)
                .padding()
                .background (RoundedRectangle(cornerRadius: 8).stroke(self.email != "" ? Color("darkGreen"): .gray, lineWidth: 2))
            TextField ("phone", text: self.$phone)
                .padding()
                .background(RoundedRectangle(cornerRadius: 8).stroke(self.phone != "" ? Color("darkGreen"): .gray, lineWidth: 2))
           
            Picker("Position", selection: self.$position) {
                ForEach(EmployeePositions.allCases, id: \.self) { pos in
                    Text(pos.rawValue)
                }
                
            }
            .background(Color("darkGreen"))
            .clipShape(.rect(cornerRadius: 8))
            .pickerStyle(.palette)
            
            Button {
                viewModel.employeeToAdd = EmployeeStruct(id: nil, name: self.name, phone: self.phone, position: self.position.rawValue, email: self.email,photoUrl: nil, bossEmail: nil)
                viewModel.addEmployee()
                dismiss()
            } label: {
                Text("Create new employee")
                    .styleOne()
            }
        }
        .padding()
        .padding(.top)
    }
}

#Preview {
    EmployeeAddView()
        .environmentObject(EmployeeViewModel())
}
