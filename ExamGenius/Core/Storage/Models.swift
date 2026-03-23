// cbtgenius/cbtgenius/Core/Storage/Models.swift
import SwiftUI
import Foundation

public enum HabitCategory: String, Codable, CaseIterable {
    case mental, physical, learning, social
    
    var icon: String {
        switch self {
        case .mental: return "brain.head.profile"
        case .physical: return "figure.run"
        case .learning: return "book.fill"
        case .social: return "person.2.fill"
        }
    }
    
    var color: String {
        switch self {
        case .mental: return "MentalColor"
        case .physical: return "PhysicalColor"
        case .learning: return "LearningColor"
        case .social: return "SocialColor"
        }
    }
}

public enum HabitFrequency: String, Codable, CaseIterable {
    case daily = "Quotidien"
    case weekly = "Hebdomadaire"
    case monthly = "Mensuel"
}

public enum HabitStatus: String, Codable {
    case active, paused, completed
}

public struct HabitCompletion: Identifiable, Codable {
    public let id: UUID
    public let date: Date
    public let note: String?
    
    public init(id: UUID = UUID(), date: Date = Date(), note: String? = nil) {
        self.id = id
        self.date = date
        self.note = note
    }
}

public struct Habit: Identifiable, Codable {
    public let id: UUID
    public var name: String
    public var category: HabitCategory
    public var frequency: HabitFrequency
    public var status: HabitStatus
    public var completions: [HabitCompletion]
    public var notes: [String]
    public var createdAt: Date
    public var streakCount: Int
    public var bestStreak: Int
    
    public init(
        id: UUID = UUID(),
        name: String,
        category: HabitCategory,
        frequency: HabitFrequency = .daily,
        status: HabitStatus = .active,
        completions: [HabitCompletion] = [],
        notes: [String] = [],
        createdAt: Date = Date(),
        streakCount: Int = 0,
        bestStreak: Int = 0
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.frequency = frequency
        self.status = status
        self.completions = completions
        self.notes = notes
        self.createdAt = createdAt
        self.streakCount = streakCount
        self.bestStreak = bestStreak
    }
}

public struct GenieMessage: Identifiable {
    public let id = UUID()
    public let type: MessageType
    public let content: String
    public let category: HabitCategory?
    public var action: (() -> Void)?
    public let timestamp: Date
    
    public var emoji: String {
        switch type {
        case .insight: return "💡"
        case .suggestion: return "🪔"
        case .celebration: return "🎉"
        case .reminder: return "⏰"
        }
    }
    
    public enum MessageType: String {
        case insight = "Observation"
        case suggestion = "Suggestion"
        case celebration = "Célébration"
        case reminder = "Rappel"
    }
}

public struct Streak: Identifiable {
    public let id = UUID()
    public let count: Int
    public let startDate: Date
    public let endDate: Date
    public let habit: Habit
}
