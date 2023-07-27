import SwiftUI

struct LogInView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                    .frame(height: 50)
                Image("startIcon")
                    .resizable()
                    .scaledToFit()
                Spacer()
                    .frame(height: 50)
                customTextField(title: "Email", result: self.$viewModel.email, isSecureField: false, placeHolder: "example@gmail.com")
                
                customTextField(title: "Пароль", result: self.$viewModel.password, isSecureField: true, placeHolder: "Введите пароль")
                Button{
                    Task{
                       try await self.viewModel.signIn()
                    }
                }label: {
                    HStack{
                        Text("Войти")
                        Image(systemName: "arrow.right")
                    }.frame(width: UIScreen.main.bounds.width - 32, height: 50)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }.background(Color.blue)
                    .cornerRadius(8)
                
                NavigationLink{
                    registerView()
                        .environmentObject(viewModel)
                        .navigationBarBackButtonHidden()
                }label: {
                    HStack{
                        Spacer()
                        Text("Нет аккаунта?")
                    }
                    .padding(.top, 10)
                    .padding(.trailing, 16)
                    
                }
                Spacer()
            }
        }
    }
}

struct logInView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AuthViewModel()
        LogInView()
            .environmentObject(viewModel)
    }
}
