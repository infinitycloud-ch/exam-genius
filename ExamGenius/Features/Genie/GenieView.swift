import SwiftUI

struct GenieView: View {
    @StateObject private var viewModel = GenieViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // En-tête avec la lampe
            GenieHeaderView()
            
            // Zone des messages
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(viewModel.messages) { message in
                        MessageBubble(message: message)
                    }
                }
                .padding()
            }
            
            // Zone de saisie
            HStack {
                TextField("Votre message...", text: $viewModel.inputMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    viewModel.sendMessage()
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .padding(.bottom)
        }
        .navigationTitle("Votre Génie CBT")
    }
}

struct GenieHeaderView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "lamp.desk.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.blue)
                .padding()
                .background(Circle().fill(Color.blue.opacity(0.2)))
                .overlay(Circle().stroke(Color.blue.opacity(0.2), lineWidth: 4))
                .shadow(radius: 5)
            
            Text("Bonjour, je suis votre Génie CBT")
                .font(.headline)
            
            Text("Je vous aide à transformer vos pensées avec sagesse")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .background(Color(.systemBackground))
    }
}

struct MessageBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUserMessage { Spacer() }
            
            Text(message.content)
                .padding()
                .background(message.isUserMessage ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(message.isUserMessage ? .white : .primary)
                .cornerRadius(15)
                .padding(.horizontal)
            
            if !message.isUserMessage { Spacer() }
        }
    }
}
