import SwiftUI

struct CalorieInfoView: View {
    
    let number: Int16
    let text:String
    
    var body: some View {
        HStack(spacing: 0){
            Text("\(number)")
                .styleMainText_15_black()
                .lineLimit(1)
                .frame(width: 50, height: 40)
                .background(Color.green)
                .clipShape(Circle())
            
            Text(text)
                .styleMainText_15_black()
                .lineLimit(1)
                .padding(.trailing)
        }
        .padding(.vertical, 5)
        .foregroundStyle(.white)
        .background(.darkGreen)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}


#Preview {
    CalorieInfoView(number: 2, text: "Some")
}
