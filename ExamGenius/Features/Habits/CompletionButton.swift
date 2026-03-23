// cbtgenius/cbtgenius/Features/Habits/CompletionButton.swift
import SwiftUI

struct CompletionButton: View {
    let isCompleted: Bool
    let action: () -> Void
    @State private var scale: CGFloat = 1
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                scale = 1.3
                action()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    scale = 1
                }
            }
        }) {
            ZStack {
                Circle()
                    .stroke(isCompleted ? Color.green : Color.blue, lineWidth: 2)
                    .frame(width: 30, height: 30)
                
                if isCompleted {
                    Image(systemName: "checkmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.green)
                }
            }
        }
        .scaleEffect(scale)
    }
}
