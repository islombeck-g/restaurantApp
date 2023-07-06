
import SwiftUI

struct AddNewEmployeer_View: View {
    @Environment(\.dismiss) var dismiss
    @StateObject
        private var viewModel = Employees_ViewModel()
    
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("Name", text: self.$viewModel.name)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(self.viewModel.name != "" ? .red: .gray, lineWidth: 2) )
                TextField("email", text: self.$viewModel.email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(self.viewModel.email != "" ? .red: .gray, lineWidth: 2))
                TextField("phone", text: self.$viewModel.phone)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke(self.viewModel.phone != "" ? .red: .gray, lineWidth: 2))
               
                Picker(selection: self.$viewModel.position, label: Text("Position")) {
                    Text("cashier").tag("cashier")
                    Text("cookier").tag("cookier")
                }
                .pickerStyle(.segmented)
                Button{
                    viewModel.add()
                    dismiss()
                }label: {
                    Text("Create employeer")
                        .foregroundColor(.blue)
                        .padding()
                    
                        .frame(width:  UIScreen.main.bounds.width - 50)
                        
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray))
                  
                    
                    
                }
                
                Spacer()
            }
            .padding(.all, 25)
            
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        dismiss()
                    }label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            
        }
        .onTapGesture {}
        
        
    }
}

//struct AddNewEmployeer_View_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewEmployeer_View()
//    }
//}
