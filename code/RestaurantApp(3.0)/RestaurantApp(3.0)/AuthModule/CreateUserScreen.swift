import SwiftUI

struct CreateUserScreen: View {
    
    @EnvironmentObject private var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            
                ZStack {
                    Image("v4")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ScrollView {
                        
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
                                .styleOne()
                        }
                        .disabled(viewModel.isLoading)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.horizontal, 32)
                    
                    ErrorText(text: self.viewModel.errorMessage)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding(.bottom, viewModel.errorMessage == "" ? -350: 80)
                        .animation(.easeInOut , value: viewModel.errorMessage)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.green)
                    }
                    
                }
            
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button { self.dismiss() } label: {
                        Image(systemName: "chevron.backward.circle.fill")
                            .foregroundStyle(Color("darkGreen"))
                    }
                    .padding()
                    .font(.system(size: 22))
                }
                ToolbarItem(placement: .topBarLeading) {
                    Text("MenuCraft")
                        .font(.custom("GillSans-Bold", size: 30))
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            self.viewModel.cleanData()
        }
    }
}

#Preview {
    CreateUserScreen()
        .environmentObject(AuthViewModel(userStateManager: UserManager.shared))
}
