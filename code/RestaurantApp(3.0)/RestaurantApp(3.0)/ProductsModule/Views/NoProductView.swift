import SwiftUI

struct NoProductView: View {
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.white)
                .shadow(color: .gray, radius: 2.5)
            
            VStack {
                
                Image("empty")
                    .resizable()
                    .scaledToFit()
                Text("No products in a restauran")
                    .font(.custom("GillSans-Bold", size: 20))
                    .foregroundStyle(.darkGreen)
            }
            .padding(.bottom)
        }
  
        
    }
}

#Preview {
    NoProductView()
}
