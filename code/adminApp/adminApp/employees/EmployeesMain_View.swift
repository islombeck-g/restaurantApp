

import SwiftUI

struct EmployeesMain_View: View {
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing){
                List{
                    Text("asdklfnldsf")
                    Text("asdklfnldsf")
                    Text("asdklfnldsf")
                    Text("asdklfnldsf")
                    Text("asdklfnldsf")
                    Text("asdklfnldsf")
                    Text("asdklfnldsf")
                    Text("asdklfnldsf")
                    Text("asdklfnldsf")
                    Text("asdklfnldsf")
              
                    
                }
                Button{
                    
                }label: {
                    Image(systemName: "plus")
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .font(.system(size: 25))
                        .cornerRadius(50)
                        
                } .offset(x: -20)
            }
        }
    }
}

struct EmployeesMain_View_Previews: PreviewProvider {
    static var previews: some View {
        EmployeesMain_View()
    }
}
