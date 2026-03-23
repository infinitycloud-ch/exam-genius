import SwiftUI

public struct GenieAction {
    public let title: String
    public let execute: () -> Void

    public init(title: String, execute: @escaping () -> Void) {
        self.title = title
        self.execute = execute
    }
}

public struct GenieInsight: Identifiable {
    public let id: UUID
    public let type: InsightType
    public let suggestion: String
    public let actionable: GenieAction?

    public enum InsightType: String {
        case pattern = "Pattern Détecté"
        case suggestion = "Suggestion"
        case celebration = "Célébration"
        case reminder = "Rappel"

        var icon: String {
            switch self {
            case .pattern: return "sparkles"
            case .suggestion: return "lightbulb.fill"
            case .celebration: return "star.fill"
            case .reminder: return "bell.fill"
            }
        }

        var color: Color {
            switch self {
            case .pattern: return .purple
            case .suggestion: return .blue
            case .celebration: return .orange
            case .reminder: return .green
            }
        }
    }

    public init(type: InsightType, suggestion: String, actionable: GenieAction?) {
        self.id = UUID()  // Correction ici : on initialise directement l'id
        self.type = type
        self.suggestion = suggestion
        self.actionable = actionable
    }
}
