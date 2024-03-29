import SwiftUI

struct EmployeesScreen: View {
    
    @EnvironmentObject private var viewModel: EmployeeViewModel
    
    @State private var selectedEmployee: EmployeeStruct?
    @State private var addNewEmployee:Bool = false

    private var columns: [GridItem] = [ GridItem(.adaptive(minimum: 300)) ]
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                Spacer()
                    .frame(height: 20)
                LazyVGrid(columns: columns, alignment:.leading, spacing: 20) {
                    ForEach(viewModel.employeeArray) { employee in
                        EmployeeListView(person: employee)
                            .padding(.horizontal, 16)
                            .onTapGesture {
                                self.selectedEmployee = employee
                            }
                    }
                }
            }
            .sheet(item: self.$selectedEmployee , content: { selectedEmployee in
                EmployyeeIDView(employee: selectedEmployee)
                    .presentationDetents([.medium])
            })
            .sheet(isPresented: self.$addNewEmployee, content: {
               EmployeeAddView()
                    .presentationDetents([.height(340)])
            })
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.addNewEmployee.toggle()
                    } label: {
                        Image(systemName: "person.crop.circle.fill.badge.plus")
                            .font(.system(size: 25))
                            .foregroundStyle(.green)
                    }
                    
                }
                ToolbarItem(placement: .topBarLeading) {
                    Text("Employees")
                        .styleMainText_30()
                        
                }
            }
        }
    }
}

#Preview {
    EmployeesScreen()
        .environmentObject(EmployeeViewModel())
}


