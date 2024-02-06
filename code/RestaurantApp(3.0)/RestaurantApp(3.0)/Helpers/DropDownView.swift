import SwiftUI

struct DropDownView: View {
    var menuActions: [DishCategory]
    @Binding var title: DishCategory
    @State private var expand: Bool = false
    
    var body: some View {
        VStack {
            DropDownHeader(
                title: title.rawValue,
                action: {
                    expand.toggle()},
                expand: expand)
            if expand {
                DropDownViewMenu(
                    menuActions: menuActions,
                    expand: self.$expand,
                    title: self.$title)
            }
            Spacer()
        }
    }
}

struct DropDownButton: View {
    
    var text: DishCategory
    @Binding var expand: Bool
    @Binding var selectedTitle: DishCategory
    
    var body: some View {
        
        Button {
            self.expand = false
            self.selectedTitle = text
        } label: {
            HStack{
                Text(text.rawValue)
                Spacer()
            }
        }
        .padding(.all, 10)
    }
}

struct DropDownViewMenu: View {
    
    var menuActions: [DishCategory]
    @Binding var expand: Bool
    @Binding var title: DishCategory
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ScrollView{
                ForEach(menuActions, id: \.self) { action in
                    DropDownButton(
                        text: action ,
                        expand: self.$expand,
                        selectedTitle: $title)
                    Divider()
                }
            }
            .frame(width: 293, height: 150)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}

struct DropDownHeader: View {
    var title: String
    var action: () -> ()
    var expand: Bool
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title + " ")
                Spacer()
                Image(systemName: "chevron.\(expand ? "up" : "down")")
            }
            .padding(.all, 10)
        }
        .frame(width: 293, height: 50)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}
//
//#Preview {
//    DropDownView()
//}
