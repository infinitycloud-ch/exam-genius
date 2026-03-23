import Foundation
import SwiftUI

@MainActor
class GenieViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var insights: [GenieInsight] = []
    @Published var inputMessage: String = ""
    
    private let modelManager: ModelManager
    
    init() {
        self.modelManager = ModelManager.shared
    }
    
    func sendMessage() {
        guard !inputMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        print("📱 Envoi message: \(inputMessage)")
        
        let userMessage = ChatMessage(content: inputMessage, isUserMessage: true)
        messages.append(userMessage)
        
        let currentMessage = inputMessage
        inputMessage = ""
        
        Task {
            print("⏳ Attente réponse...")
            let response = await modelManager.generateResponse(from: currentMessage)
            print("✅ Réponse reçue: \(response)")
            
            // Pas besoin de MainActor.run car la classe est déjà @MainActor
            let botMessage = ChatMessage(content: response, isUserMessage: false)
            messages.append(botMessage)
        }
    }
}
