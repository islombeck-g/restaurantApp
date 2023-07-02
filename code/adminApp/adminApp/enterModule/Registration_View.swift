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
                            
                        
                        TextField("Email", text: self.$email)
                            .padding()
                            
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color.red: self.color, lineWidth: 2))
                            
                       
                        
                        HStack(spacing: 15){
                            VStack{
                                if self.visible{
                                    TextField("Password", text: self.$password)
                                        
                                }else{
                                    SecureField("Password", text: self.$password)
                                        
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
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color.red: self.color, lineWidth: 2))

                        HStack(spacing: 15){
                            VStack{
                                if self.reVisible{
                                    TextField("Password", text: self.$rePassword)
                                        
                                }else{
                                    SecureField("Password", text: self.$rePassword)
                                        
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
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.rePassword != "" ? Color.red: self.color, lineWidth: 2))
                        Button{
                            self.verify()
                        }label: {
                            Text("LogIn")
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
    func verify(){
        if self.email != "" && self.password != "" && self.rePassword != ""{
            
        }else{
            self.error = "Fill all"
            self.alert.toggle()
        }
    }
}

struct Registration_view_Previews: PreviewProvider {
    @State static var isLogged = true
    static var previews: some View {
        Registration_View(wichView: $isLogged)
    }
}
