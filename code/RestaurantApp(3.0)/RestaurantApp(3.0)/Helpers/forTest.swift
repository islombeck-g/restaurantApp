//import SwiftUI

//struct forTest: View {
//
//    @State var selectedTab:tabs = .two
//    var body: some View {
//            ZStack {
//                VStack {
//
//                    TabView(selection: $selectedTab){
//                        one()
//                            .tag(tabs.one)
//                        two()
//                            .tag(tabs.two)
//                        tree()
//                            .tag(tabs.tree)
//                    }
//                    .toolbar(.hidden, for: .tabBar)
//
////                    .tabViewStyle(.page(indexDisplayMode: .never))
//                }
//                Custom(selectedTab: $selectedTab)
//                    .frame(maxHeight: .infinity, alignment: .bottom)
//            }
//    }
//}
////UITabBar.appearance().isHidden = true
//#Preview {
//    forTest()
//}
//
//
//struct one: View {
//
//    var body: some View {
//        NavigationStack {
//            NavigationLink {
//                four()
//            } label: {
//                Text("tabToChangeView")
//                    .styleOne()
//            }
//            ScrollView {
//                ForEach(0..<200) { me in
//                    Text("One")
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Text("Products")
//                        .styleMainText_30()
//                }
//            }
//            .toolbar(.hidden, for: .tabBar)
//        }
////        .toolbar(.hidden, for: .tabBar)
//
//    }
//}
//struct two: View {
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                ForEach(0..<100) { me in
//                    Text("Two")
//                }
//            }
//
//        }
//
//    }
//}
//struct tree: View {
//
//    var body: some View {
//        VStack {
//            ForEach(0..<100) { me in
//                Text("Tree")
//            }
//        }
//    }
//}
//
//struct four:View {
//    var body: some View {
//        Text("four")
//            .onAppear {
//                print("start Four")
//            }
//    }
//}
//
//
//
//struct Custom: View {
//
//    @Binding var selectedTab: tabs
//    private var fillImage: String {
//        selectedTab.rawValue + ".fill"
//    }
//    var body: some View {
//        VStack {
//            HStack {
//                ForEach (tabs.allCases, id: \.rawValue) { tab in
//                    Spacer()
//                    Image(systemName:  selectedTab == tab ? fillImage : tab.rawValue)
//                        .scaleEffect(selectedTab == tab ? 1.55: 1.15)
//                        .padding()
//                        .foregroundStyle(selectedTab == tab ? Color("darkGreen"): .green)
//                        .onTapGesture {
//                            withAnimation {
//                                selectedTab = tab
//                            }
//                        }
//                    Spacer()
//                }
//            }
//            .frame(height: 60)
//            .background(.thinMaterial)
//            .clipShape(.rect(cornerRadius: 8))
//            .padding()
//        }
//    }
//}
//enum tabs:String, CaseIterable {
//    case one = "cube.box"
//    case two = "menucard"
//    case tree = "person.3"
//}

import SwiftUI

//struct ContentView: View {
//
//    @State var items = ["Item 1", "Item 2", "Item 3"]
//
//    var body: some View {
//        NavigationStack {
//            ForEach(items, id: \.self) { item in
//
//
//
//
//            }
//        }
//    }
//}



#Preview {
    ContentView()
}



struct ContentView: View {
    
    @State var dataC: [Card] = [Card(id: 0, title: "one", expand: false),Card(id: 2, title: "two", expand: false), Card(id: 1, title: "tree", expand: false), Card(id: 3, title: "four", expand: false), Card(id: 4, title: "five", expand: false)]
    
    @State private var isHeroAnimation:Bool = false
    var body: some View {
        
            ScrollView {
                ForEach(0..<self.dataC.count) { i in
                    GeometryReader { geometry in
                        
                        CardView(data: self.$dataC[i], hero:self.$isHeroAnimation)
                            .offset(y: self.dataC[i].expand ? -geometry.frame(in: .global).minY: 0)
                            .opacity(self.isHeroAnimation ? (self.dataC[i].expand ? 1 : 0) : 1)
                            .padding(.horizontal, self.dataC[i].expand ? 0 : 16)
                            .onTapGesture {
//                                if !self.isHeroAnimation {
                                    withAnimation {
                                        self.isHeroAnimation.toggle()
                                        self.dataC[i].expand.toggle()
//                                    }
                                }
                                
                                
                            }
                    }
                    .frame(height: self.dataC[i].expand ? UIScreen.main.bounds.height : 250)
                    .simultaneousGesture(
                        DragGesture(minimumDistance: self.dataC[i].expand ? 0 : 500).onChanged({ (_) in
                            print("dragging")
                            
                        })
                    )
                }
            }
        }
}

struct CardView: View {
    
    @Binding var data: Card
    @Binding var hero: Bool
    
    var body: some View {
        VStack {
            Image(self.data.image)
                .resizable()
                .frame(height: self.data.expand ? 350 : 250)
                .clipShape(.rect(cornerRadius: self.data.expand ? 0 : 25))
            
//            Spacer()
        }
        .contentShape(Rectangle())
            
    }
}
struct Card:Identifiable {
    
    let id:Int
    let title:String
    let image = "defaultDish"
    var expand: Bool
}



struct DetailView: View {
    
    @Binding var boolean: Bool
    
    var body: some View {
        VStack {
            Text("Full information View")
                .frame(width: 200, height: 120)
                .foregroundStyle(.white)
                .background(.green)
            Spacer()
            Button {
                withAnimation(.bouncy) {
                    boolean.toggle()
                }
            } label: {
                Text("close")
                    .foregroundStyle(.white)
                    .background(.red)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        
    }
}

struct CanvasView: View {
    var body: some View {
        Canvas { context, size in
            let rect = CGRect(origin: .zero, size: size).insetBy(dx: 25, dy: 25)

            // Path
            let path = Path(roundedRect: rect, cornerRadius: 35.0)

            // Gradient
            let gradient = Gradient(colors: [.green, .blue])
            let from = rect.origin
            let to = CGPoint(x: rect.width + from.x, y: rect.height + from.y)
            
            // Stroke path
            context.stroke(path, with: .color(.blue), lineWidth: 25)
            
            // Fill path
            context.fill(path, with: .linearGradient(gradient,
                                                     startPoint: from,
                                                     endPoint: to))
        }
    }
}


//struct CardView: View {
//
//    @Namespace var nspace
//
//    @Binding var flag: Bool
//
//    var body: some View {
//        VStack {
//
//            Rectangle().fill(Color.yellow).frame(width: 50, height: 50)
//            if !flag {
//                Circle()
//                    .fill(Color.blue)
//                    .matchedGeometryEffect(id: "g", in: nspace)
//                    .frame(width: 50, height: 50)
//                    .border(Color.black)
////                    .zIndex(1)
//            }
//
//        }
//    }
//}

