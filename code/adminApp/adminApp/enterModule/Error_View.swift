import SwiftUI

struct Error_View: View {
    @State private var color = Color.black.opacity(0.7)
    @Binding var alert: Bool
    @Binding var error:String
    var body: some View {
        GeometryReader{geometry in
            VStack{
                HStack{
                    Text("Error")
                        .font(.title)
                        .foregroundColor(self.color)
                    
                }
                .padding(.horizontal, 25)
                Image("error_01")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250.0, height: 250.0)
                Text(self.error)
                    .foregroundColor(self.color)
                    .padding(.top)
                    .padding(.horizontal, 25)
                Button{self.alert.toggle()}label: {
                    Text("Cansel")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 120)
                }
                .background(Color.red)
                .cornerRadius(8)
                .padding(.top, 25)
            }
            .padding(.vertical, 25)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(Color.orange)
            .cornerRadius(15)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .background(Color.black.opacity(0.3).edgesIgnoringSafeArea(.all))
    }
}

struct Error_View_Previews: PreviewProvider {
    @State static var me = true
    @State static var str = "someError"
    static var previews: some View {
        Error_View(alert: $me, error: $str)
    }
}
