import SwiftUI

struct LogIn_View: View {
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var password = ""
    @State var visible = false
    @Binding var wichView:Bool
    @State var alert = false
    @State var error = ""
    var body: some View{
        ZStack{
            ZStack(alignment: .topTrailing){
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
                            Spacer()
                            Button{}label: {
                                Text("Forget Password")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.red)
                            }
                        }.padding(.top, 25)
                        
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
                    Text("Registration")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }.padding()
            }
            if self.alert{
                Error_View(alert: $alert, error: $error)
            }
        }
    }
    func verify(){
        if self.email != "" && self.password != ""{
            
        }else{
            self.error = "Fill all"
            self.alert.toggle()
        }
    }

}

struct LogIn_View_Previews: PreviewProvider {
    @State static var isLogged = false
    static var previews: some View {
        LogIn_View(wichView: $isLogged)
        
    }
}
