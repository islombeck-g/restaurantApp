import SwiftUI

struct DropDownView: View {
    var menuActions: [DishCategory]
    @Binding var title: DishCategory
    @State private var expand: Bool = false
    
    var body: some View {
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
            
            Text(text.rawValue)
                .foregroundStyle(.white)
                .styleMainText_15()
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(.all, 10)
    }
}

struct DropDownViewMenu: View {
    
    var menuActions: [DishCategory]
    @Binding var expand: Bool
    @Binding var title: DishCategory
    
    var body: some View {
        ScrollView {
            ForEach(menuActions, id: \.self) { action in
                DropDownButton(
                    text: action ,
                    expand: self.$expand,
                    selectedTitle: $title)
                Divider()
            }
        }
        .background(.darkGreen)
        .frame(height: 150)
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
                    .foregroundStyle(.white)
                    .styleMainText_15()
                Spacer()
                Image(systemName: "chevron.\(expand ? "up" : "down")")
            }
            .padding(.all, 10)
        }
//        .frame(width: 293, height: 50)
        .frame(height: 50)
        .foregroundStyle(.white)
        .background(.darkGreen)
        .clipShape(
            RoundedRectangle(cornerRadius: 10.0)
        )
    }
}
//
//#Preview {
//    DropDownView()
//}

#Preview {
    CreateNewDishScreen()
        .environmentObject(MenuViewModel(productsService: ProductsService()))
        .environmentObject(CustomNavigationStack())
}
