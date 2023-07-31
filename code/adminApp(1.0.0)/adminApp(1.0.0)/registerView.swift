import SwiftUI

struct registerView: View {
    @EnvironmentObject var viewModel:AuthViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Group{
                Spacer()
                    .frame(height: 50)
                Image("startIcon")
                    .resizable()
                    .scaledToFit()
                Spacer()
                    .frame(height: 50)
            }
            
            customTextField(title: "Имя", result: self.$viewModel.name, isSecureField: false, placeHolder: "Иван")
            
            customTextField(title: "Email", result: self.$viewModel.email, isSecureField: false, placeHolder: "example@gmail.com")
            
            customTextField(title: "Пароль", result: self.$viewModel.password, isSecureField: true, placeHolder: "Введите пароль")
            
            customTextField(title: "Повторите пароль", result: self.$viewModel.password1, isSecureField: true, placeHolder: "Повторите пароль")
            Button{
                Task{
                    try await self.viewModel.createUser()
                    print("i tries createUser")
                }
            }label: {
                HStack{
                    Text("Зарегистрироваться")
                    Image(systemName: "arrow.right")
                }.frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }.background(Color.blue)
                .cornerRadius(8)
            Group{
                Spacer()
                    .frame(height: 20)
                Button{
                    dismiss()
                }label: {
                    
                    HStack{
                        Spacer()
                        Text("Уже есть аккаунт?")
                        Text("Войди")
                            .fontWeight(.bold)
                    }
                    

                    .padding(.trailing, 16)
                }
                
                Spacer()
            }
            
            if self.viewModel.error != nil {
                Text(self.viewModel.error!)
                    .foregroundColor(.red)
                    .fontWeight(.bold)
            }
            
        }
    }
}

struct registerView_Previews: PreviewProvider {
    static var previews: some View {
        registerView()
            .environmentObject(AuthViewModel())
    }
}
