import SwiftUI

struct Registration_View: View {
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var password = ""
    @State var visible = false
    @State var rePassword = ""
    @State var reVisible = false
    @Binding var wichView:Bool
    @State private var error = ""
    @State var alert = false
    @Binding var authView:Bool
    @StateObject var viewModel = AuthEmailViewModel()
    var body: some View{
        ZStack{
            ZStack(alignment: .topLeading){
                GeometryReader{_ in
                    VStack{
                       Image("robot")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250.0, height: 250.0)
                            .padding(.top, 100)
                        Text("Log-in to your account")
                            .font(.title2)
                            
                        
                        TextField("Email", text: self.$viewModel.email)
                            .padding()
                            
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.viewModel.email != "" ? Color.red: self.color, lineWidth: 2))
                            
                       
                        
                        HStack(spacing: 15){
                            VStack{
                                if self.visible{
                                    TextField("Password", text: self.$viewModel.password)
                                        
                                }else{
                                    SecureField("Password", text: self.$viewModel.password)
                                        
                                }
                            }
                            Button{
                                self.visible.toggle()
                            }label: {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.viewModel.password != "" ? Color.red: self.color, lineWidth: 2))

                        HStack(spacing: 15){
                            VStack{
                                if self.reVisible{
                                    TextField("Password", text: self.$viewModel.rePassword)
                                        
                                }else{
                                    SecureField("Password", text: self.$viewModel.rePassword)
                                        
                                }
                            }
                            Button{
                                self.reVisible.toggle()
                            }label: {
                                Image(systemName: self.reVisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.viewModel.rePassword != "" ? Color.red: self.color, lineWidth: 2))
                        Button{
                            Task{
                                let result = self.viewModel.signUp()
                                
                                    let value = try await result.value
                                    // Task succeeded, value contains the success string
                                    if value == "success" {
                                        authView.toggle()
                                    } else {
                                        self.error = value
                                        self.alert.toggle()
                                    }
                               
                                
                            }                        }label: {
                            Text("LogUp")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color.red)
                        .cornerRadius(8)
                    }
                    .padding(.horizontal, 25)
                    
                }
                Button{
                    self.wichView.toggle()
                }label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.red)
                }.padding()
            }
        }
        if self.alert{
            Error_View(alert: $alert, error: $error)
        }
    }
  
}

struct Registration_view_Previews: PreviewProvider {
    @State static var isLogged = true
    static var previews: some View {
        Registration_View(wichView: $isLogged, authView: .constant(true))
    }
}
