import SwiftUI

struct CustomTextField: View {
    
    @State private var showPassword: Bool = false
    
    let name:String
    @Binding var text:String
    let isSecured:Bool
    
    var body: some View {
        if isSecured {
            HStack {
                if showPassword {
                    TextField(name, text: $text)
                        .font(.system(size: 22))
                } else {
                    SecureField(name, text: $text)
                        .font(.system(size: 22))
                }
                Button {showPassword.toggle()} label: {
                    Image(systemName: showPassword ? "eye.fill": "eye.slash.fill")
                }
                .foregroundStyle(.black)
            }
            
        } else {
            TextField(name, text: $text)
                .font(.system(size: 22))
        }
        Divider()
    }
        
}

#Preview {
    CustomTextField(name: "Email", text: .constant(""), isSecured: true)
}
