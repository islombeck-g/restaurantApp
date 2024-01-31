import SwiftUI

struct ErrorText: View {
    let text:String
    var body: some View {
        Text(text)
            .foregroundStyle(.red)
            .padding()
            .background(Color.green.opacity(0.2))
            .clipShape(
                .rect(cornerRadius: 8)
            )
            
        
    }
}

#Preview {
    ErrorText(text: "someError")
}
