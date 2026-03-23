import SwiftUI

@main
struct CBT_Private_AI_GeniusApp: App {
    private let modelManager = ModelManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelManager)
                .task { @MainActor in
                    let success = await self.modelManager.testModel()
                    if !success {
                        print("❌ Échec initialisation modèle")
                    }
                }
        }
    }
}
