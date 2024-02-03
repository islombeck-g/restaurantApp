import SwiftUI

struct MenuListItemView: View {
   
    let picture: UIImage
    let stars: Double
    
    var body: some View {
        VStack {
            ZStack {
                //                Image(uiImage: picture)
                Image("1")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 100)
                //                    .clipShape(.rect(cornerRadius: 8))
                    .clipped()
                //                .frame(maxWidth: 350)
                
                Group {
                    HStack {
                        Image(systemName: "star.fill")
                        Text(String(format: "%.2f", stars))
                            .styleMainText_15_black()
                            .bold()
                    }
                }
                .foregroundStyle(.white)
                .font(.system(size: 12))
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.leading, 16)
                .padding(.bottom, 8)
                
            }
            Group {
                Text("Some name")
                    .styleMainText_20_black()
                Text("Some name")
                    .styleMainText_15_black()       
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            
        }
        .frame(height: 158)
        .frame(maxWidth: 400)
        .background(.red)
        .clipShape(.rect(cornerRadius: 8))
    }
}

//#Preview {
//    MenuListItemView(picture: UIImage(resource: <#T##ImageResource#>))
//}
#Preview {
    CreateNewDishScreen()
        .environmentObject(MenuViewModel())
}
