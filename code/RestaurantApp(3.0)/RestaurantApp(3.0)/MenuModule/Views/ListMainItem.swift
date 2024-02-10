import SwiftUI

struct ListMainItem: View {
    
    let picture: UIImage
    let stars: Double
    let description: String
    let name: String
    
    
    var body: some View {
        VStack {
            ZStack {
                Image(uiImage: picture)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 100)
                    .clipped()
                
                
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
                Text(self.name != "" ? name :"Name of new dish")
                    .styleMainText_20_black()
                Text(self.description != "" ? description :"Description of new dish")
                    .styleMainText_15_black()
                    .lineLimit(1)
            }
            
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            
        }
        .frame(maxWidth: 400)
        .background(.thickMaterial )
        .clipShape(.rect(cornerRadius: 8))
    }
}
//#Preview {
//    ListMainItem(picture: UIImage(.default), stars: 20, description: "desc", name: "name")
//}
