import SwiftUI

struct EmployeerListView: View {
    
    let person: EmployeeStruct
    
    var body: some View {
        HStack {
            Image(person.photoUrl ?? "user")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.leading, 16)
            
            Text(person.name)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
                .frame(width: 3)
                .overlay(.black)
            Text(person.position)
                .padding(.trailing, 16)
        }
        .frame(height: 80)
        
        .frame(minWidth: 360, maxWidth: 460)
        .background(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 3))
//        .padding()
        
    }
}

#Preview {
//    EmployeerListView(
//        person: EmployeeStruct(
//            id: "",
//            name: "Some Name",
//            phone: "79001239323",
//            position: "cashier" ,
//            email: "some@gmail.com",
//            photoUrl: "user",
//            bossEmail: "boss@gmail.com"))
    EmployeesScreen()
        .environmentObject(EmployeeViewModel())
}

