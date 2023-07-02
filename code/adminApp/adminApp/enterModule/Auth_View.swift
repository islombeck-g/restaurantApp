
import SwiftUI

struct Auth_View: View {
    @State private var wichView = false
    var body: some View {
        NavigationStack{
            ZStack{
                if wichView{
                    Registration_View(wichView: self.$wichView)
                }else{
                    
                    LogIn_View(wichView: self.$wichView)}
            }
        }
    }
}

struct Auth_View_Previews: PreviewProvider {
    static var previews: some View {
        Auth_View()
    }
}
