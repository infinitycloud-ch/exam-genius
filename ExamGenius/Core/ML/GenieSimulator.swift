// cbtgenius/cbtgenius/Core/ML/GenieSimulator.swift
import Foundation
import SwiftUI

class GenieSimulator {
    enum Scenario {
        case morningCheckIn
        case completedHabit
        case streak
        case multipleHabits
        case newDay
    }

    static func simulateScenario(_ scenario: Scenario) -> GenieMessage {
        switch scenario {
        case .morningCheckIn:
            return GenieMessage(
                type: .insight,
                content: "🌅 Bonjour ! Je vois que la méditation fonctionne bien pour vous le matin.",
                category: .mental,
                timestamp: Date()
            )
        case .completedHabit:
            return GenieMessage(
                type: .celebration,
                content: "✨ Belle session de lecture aujourd'hui !",
                category: .learning,
                timestamp: Date()
            )
        case .streak:
            return GenieMessage(
                type: .celebration,
                content: "🔥 5 jours consécutifs d'exercice !",
                category: .physical,
                timestamp: Date()
            )
        case .multipleHabits:
            return GenieMessage(
                type: .insight,
                content: "🎯 Belle synergie !",
                category: .mental,
                timestamp: Date()
            )
        case .newDay:
            return GenieMessage(
                type: .suggestion,
                content: "🌟 Nouveau jour, nouvelles possibilités !",
                category: nil,
                timestamp: Date()
            )
        }
    }
}
