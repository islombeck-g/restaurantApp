import SwiftUI

struct CreateUserScreen: View {
    
    @EnvironmentObject private var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("v4")
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack {
                    Text("MenuCraft")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("GillSans-Bold", size: 30))
                    
                    Spacer()
                        .frame(height: 20)
                    CustomTextField(name: "Login", text: self.$viewModel.name, isSecured: false)
                    Spacer()
                        .frame(height: 15)
                    CustomTextField(name: "Email", text: self.$viewModel.email, isSecured: false)
                    Spacer()
                        .frame(height: 15)
                    CustomTextField(name: "Password", text: self.$viewModel.password, isSecured: true)
                    Spacer()
                        .frame(height: 15)
                    CustomTextField(name: "Repeat Password", text: self.$viewModel.repeadPassword, isSecured: true)
                
                    Button {
                        Task {
                            await viewModel.tryCreateNewUser()
                        }
                    } label: {
                        Text("Continue")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("darkGreen"))
                            .clipShape(.rect(cornerRadius: 8))
                            .padding(.vertical)
                            .bold()
                    }
                    .disabled(viewModel.isLoading)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, 32)
                
                ErrorText(text: self.viewModel.errorMessage)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, viewModel.errorMessage == "" ? -150: 80)
                    .animation(.easeInOut , value: viewModel.errorMessage)
                
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.green)
                }
                
            }
        }
    }
}

#Preview {
    CreateUserScreen()
        .environmentObject(AuthViewModel(userStateManager: UserManager.shared))
}
