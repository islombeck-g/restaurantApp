import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack{
            List{
                Section{
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 100)
                                .foregroundColor(.gray)

                            Image("defaultImage")
                                .resizable()
                                .scaledToFit()
                                
                        }.frame(width: 72, height: 72)
                        VStack(alignment: .leading, spacing: 4){
                            Text("SomeName")
                                .fontWeight(.semibold)
//                                .font(.subheadline) добавить если размер будет слишком большим
                            Text("SomeGmail.com")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            
                        }
                    }
                    
                }
                
                Section("Основные"){
                    
                    HStack{
                        imagePlusTextView(imageName: "gear", title: "Версия", imageColor: .black)
                        Spacer()
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                Section("Аккаунт"){
                    Button{}label: {
                        imagePlusTextView(imageName: "arrow.left.circle.fill", title: "Выйти из аккаунта", imageColor: .red)
                    }
                    Button{}label: {
                        imagePlusTextView(imageName: "xmark.circle.fill", title: "Удалить аккаунт", imageColor: .red)
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
