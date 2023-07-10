import SwiftUI

struct ContentView: View {
    @State private var selectedOption = "Option 1"
    let options = ["Option 1", "Option 2", "Option 3"]

    var body: some View {
        NavigationStack {
            Text("Выберите опцию:")
                .font(.title)
                .padding()

            NavigationLink(destination: EditView(selectedOption: $selectedOption)) {
                Text(selectedOption)
                    .font(.title)
                    .padding()
            }

            Text("Выбранная опция: \(selectedOption)")
                .font(.title)
                .padding()
        }
    }
}

struct EditView: View {
    @Binding var selectedOption: String
    let options = ["Option 1", "Option 2", "Option 3"]

    var body: some View {
        VStack {
            Text("Измените опцию:")
                .font(.title)
                .padding()

            Picker(selection: $selectedOption, label: Text("")) {
                ForEach(options, id: \.self) { option in
                    Text(option)
                }
            }
            .pickerStyle(.segmented)

            Text("Выбранная опция: \(selectedOption)")
                .font(.title)
                .padding()
        }
        .navigationBarTitle(Text("Редактирование"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
