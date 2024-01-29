import SwiftUI

struct EmployeesScreen: View {
    
    @EnvironmentObject private var viewModel: EmployeeViewModel
    
    @State private var selectedEmployee: EmployeeStruct?
    
    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 360))
//        GridItem(Array(repeating: .init(.flexible()),
//                                count: UIDevice.current.userInterfaceIdiom == .pad ? 4 : 2))
    ]
    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, alignment:.leading, spacing: 20) {
                    ForEach(viewModel.employeeArray) { employee in
                        EmployeerListView(person: employee)
                            .padding(.horizontal, 16)
                    }
                }
            }
            .navigationTitle("Employees")
        }
    }
}

#Preview {
    EmployeesScreen()
        .environmentObject(EmployeeViewModel())
}



