
import SwiftUI

struct ImageSelect_View: View {
    @Environment(\.dismiss) var dismiss
    @Binding var me:String
    private let gridItem = [
        GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItem, spacing: 12){
                ForEach(imageList, id: \.self){image in
                    Button{
                        self.me = image.name
                        self.dismiss()
                    }label:{
                        Image(image.name)
                            .resizable()
                            .frame(width: 150, height: 150)
                    }
                }
            }
        }
    }
}

struct ImageSelect_View_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelect_View(me: .constant("adsf"))
        
    }
}
