import SwiftUI

struct AuthScreen: View {
    
    @EnvironmentObject var viewModel:AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        ZStack(alignment: .top) {
                            
                            Image("v1")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .frame(height: geometry.size.height/2.5)
                            
                            Image("v2")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geometry.size.height/2.5)
                                .padding(.top, 60)
                                .padding(.trailing, 70)
                            
                            Image("v3")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geometry.size.height/2.5)
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                        }
                        .frame(height: geometry.size.height/2)
                        .padding(.top, -30)
                        
                        Group {
                            CustomTextField(name: "Email", text: self.$viewModel.email, isSecured: false)
                            
                            Spacer()
                                .frame(height: 30)
                            
                            CustomTextField(name: "Password", text: self.$viewModel.password, isSecured: true)
                            
                            HStack {
                                Button {
                                    self.viewModel.rememberUser.toggle()
                                }label: {
                                    HStack {
                                        Image(systemName: self.viewModel.rememberUser ? "checkmark.square": "square")
                                        Text("Remember me")
                                        
                                    }
                                    .foregroundStyle(.black)
                                    .font(.system(size: 20))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                NavigationLink{} label: {
                                    Text("Forgot Password?")
                                }.foregroundStyle(Color("darkGreen"))
                                
                            }
                            .padding(.top, 30)
                            
                            Button {
                                
                                Task {
                                    await self.viewModel.tryAuth()
                                }
                                
                            } label: {
                                Text("Login")
                                    .foregroundStyle(.white)
                                    .bold()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("darkGreen"))
                            .clipShape(.rect(cornerRadius: 8))
                            .padding(.top, 30)
                            
                            Button{
                                viewModel.email = "w@gmail.com"
                                viewModel.password = "1234567890"
                            } label: {
                                Text("testData")
                            }
                            
                            HStack {
                                Text("Don't have account?")
                                NavigationLink { CreateUserScreen() } label: {
                                    Text("Sign Up")
                                }
                            }
                            .font(.system(size: 20))
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .padding(.bottom, 40)
                        }
                        .padding(.horizontal, 32)
                        
                    }
                }
                .ignoresSafeArea()
                
                ErrorText(text: self.viewModel.errorMessage)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, viewModel.errorMessage == "" ? -150: 80)
                    .animation(.easeInOut , value: viewModel.errorMessage)
                if self.viewModel.isLoading {
                    ProgressView()
                        .tint(.green)
                }
            }
        }
        .onAppear {
            self.viewModel.cleanData()
        }
    }
}

#Preview {
    AuthScreen()
        .environmentObject(AuthViewModel(userStateManager: UserManager()))
}
