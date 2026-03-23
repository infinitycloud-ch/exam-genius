// cbtgenius/cbtgenius/Core/ML/CBTAnalyzer.swift
import Foundation
import SwiftUI

class CBTAnalyzer: ObservableObject {
    static let shared = CBTAnalyzer()
    @Published var messages: [GenieMessage] = []
    
    private init() {
        setupInitialMessages()
    }
    
    private func setupInitialMessages() {
        messages = [
            GenieMessage(
                type: .insight,
                content: "Bienvenue ! Je suis votre Génie CBT personnel.",
                category: nil,
                timestamp: Date()
            )
        ]
    }
    
    func analyzeHabits(_ habits: [Habit]) {
        var newMessages: [GenieMessage] = []
        
        for habit in habits.filter({ $0.streakCount > 0 }) {
            newMessages.append(
                GenieMessage(
                    type: .celebration,
                    content: "Bravo ! Vous maintenez '\(habit.name)' depuis \(habit.streakCount) jours !",
                    category: habit.category,
                    timestamp: Date()
                )
            )
        }
        
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 6 && hour <= 9 {
            newMessages.append(
                GenieMessage(
                    type: .suggestion,
                    content: "C'est le matin, le moment idéal pour vos habitudes !",
                    category: nil,
                    timestamp: Date()
                )
            )
        }
        
        withAnimation {
            messages = newMessages
        }
    }
    
    func generateSuggestion() -> GenieMessage {
        let suggestions = [
            "Prenez un moment pour réfléchir à vos progrès.",
            "Une petite victoire est toujours une victoire !",
            "La constance est la clé du succès.",
            "Chaque jour est une nouvelle opportunité."
        ]
        
        return GenieMessage(
            type: .suggestion,
            content: suggestions.randomElement() ?? suggestions[0],
            category: nil,
            timestamp: Date()
        )
    }
}
