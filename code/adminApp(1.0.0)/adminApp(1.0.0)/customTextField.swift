import SwiftUI

struct customTextField: View {
    let title:String
    @Binding var result:String
    let isSecureField:Bool
    let placeHolder:String
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(title)
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .font(.footnote)
            if isSecureField {
                SecureField(placeHolder, text: $result)
                    .font(.system(size: 14))
            }else{
                TextField(placeHolder, text: $result)
                    .font(.system(size: 14))
            }
            Divider()
        }.padding()
    }
}

struct customTextField_Previews: PreviewProvider {
    
    static var previews: some View {
        @State var me = ""
        customTextField(title: "Введите почту", result: $me, isSecureField: false, placeHolder: "example@gmail.com")
    }
}
