import SwiftUI

struct GoToNextViewButton: View {
    var body: some View {
        ZStack  {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color("backgroundColor"))
                .shadow(color: .gray, radius: 2.5)
            HStack {
                Text("Go to the market")
                    .styleMainText()
                    .foregroundStyle(Color("darkGreen"))
                Image("vegetables")
            }
            .padding(.vertical)
        }
        .padding(.vertical)
        .frame(minWidth: 300, maxWidth: 450)
    }
}

#Preview {
    GoToNextViewButton()
}
