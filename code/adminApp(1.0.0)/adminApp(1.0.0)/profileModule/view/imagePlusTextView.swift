
import SwiftUI

struct imagePlusTextView: View {
    let imageName:String
    let title:String
    let imageColor:Color
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(imageColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
            
        }
    }
}

struct imagePlusTextView_Previews: PreviewProvider {
    static var previews: some View {
        imagePlusTextView(imageName: "gear", title: "delete accaunt", imageColor: Color.red)
    }
}
