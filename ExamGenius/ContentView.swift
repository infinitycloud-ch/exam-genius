import SwiftUI

struct ContentView: View {
    @State private var userInput = ""
    @StateObject private var viewModel = GenieViewModel()
    
    var body: some View {
        TabView {
            GenieView()
                .tabItem {
                    Label("Assistant", systemImage: "brain.head.profile")
                }
            
            HabitsView()
                .tabItem {
                    Label("Habitudes", systemImage: "list.bullet")
                }
            
            StatsView(viewModel: HabitsViewModel())
                .tabItem {
                    Label("Statistiques", systemImage: "chart.bar")
                }
        }
    }
}

#Preview {
    ContentView()
}
