import Foundation

struct ChatMessage: Identifiable {
    let id: UUID
    let content: String
    let isUserMessage: Bool
    
    init(id: UUID = UUID(), content: String, isUserMessage: Bool) {
        self.id = id
        self.content = content
        self.isUserMessage = isUserMessage
    }
}
