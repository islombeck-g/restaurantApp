import SwiftUI

struct ContentView: View {
    @State private var selectedElement: String?
    
    let elements = ["Element 1", "Element 2", "Element 3"]
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(elements, id: \.self) { element in
                    NavigationLink(
                        destination: DetailView(element: element),
                        tag: element,
                        selection: $selectedElement
                    ) {
                        Text(element)
                            .padding()
                            .onTapGesture {
                                selectedElement = element
                            }
                    }
                }
            }
            .navigationTitle("Main View")
        }
    }
}

struct DetailView: View {
    let element: String
    
    var body: some View {
        Text("Detail for \(element)")
            .navigationBarTitle(element)
    }
}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
