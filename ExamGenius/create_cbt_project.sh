#!/bin/bash

# Couleurs pour le terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Nom du projet
PROJECT_NAME="CBT Private AI Genius"
BASE_DIR="$PROJECT_NAME"

echo -e "${BLUE}Création du projet $PROJECT_NAME...${NC}"

# Création de la structure des dossiers
mkdir -p "$BASE_DIR"/{Core/{ML,Storage,Types},Features/{Genie,Habits,Insights}}

# Fonction pour créer un fichier Swift
create_swift_file() {
local path=$1
local content=$2
echo "$content" > "$path"
echo -e "${GREEN}Créé: $path${NC}"
}

# Core/Types/GenieTypes.swift
create_swift_file "$BASE_DIR/Core/Types/GenieTypes.swift" '
import SwiftUI

public struct GenieInsight: Identifiable {
public let id = UUID()
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
        }

public struct GenieAction {
public let title: String
public let execute: () -> Void

    public init(title: String, execute: @escaping () -> Void) {
    self.title = title
    self.execute = execute
    }
    }'

# Core/Storage/ChatMessage.swift
create_swift_file "$BASE_DIR/Core/Storage/ChatMessage.swift" '
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
    }'

# Core/ML/CBTAnalyzer.swift
create_swift_file "$BASE_DIR/Core/ML/CBTAnalyzer.swift" '
import Foundation

class CBTAnalyzer {
static let shared = CBTAnalyzer()

    enum ColdReadingTechnique {
    case barnum
    case rainbow
    case observation
    case validation

        var patterns: [String] {
        switch self {
        case .barnum:
        return [
        "Je sens que vous êtes quelquun qui apprécie vraiment la qualité dans [habitude]",
        "Vous avez une capacité naturelle à [habitude], même si parfois vous doutez"
        ]
        case .rainbow:
        return [
        "Bien que vous soyez discipliné(e) avec [habitude], vous savez aussi être flexible",
        "Vous alternez entre des périodes très focalisées et des moments de réflexion"
        ]
        case .observation:
        return [
        "Jobserve que vous excellez particulièrement dans [habitude] le [moment]",
        "Votre engagement est plus fort quand vous [contexte]"
        ]
        case .validation:
        return [
        "Votre approche de [habitude] montre une vraie compréhension",
        "Ce que vous faites avec [habitude] est remarquable"
        ]
        }
        }
        }

    func generatePersonalizedSuggestion(for habit: Habit) -> GenieMessage {
    // Implementation détails...
    return GenieMessage(
    type: .suggestion,
    content: "Suggestion personnalisée pour \(habit.name)",
    category: habit.category,
    timestamp: Date()
    )
    }
    }'

# Features/Genie/GenieViewModel.swift
create_swift_file "$BASE_DIR/Features/Genie/GenieViewModel.swift" '
import Foundation
import SwiftUI
import Combine

class GenieViewModel: ObservableObject {
@Published var messages: [ChatMessage] = []
@Published var insights: [GenieInsight] = []
@Published var inputMessage: String = ""

    private let analyzer = CBTAnalyzer.shared

    init() {
    setupInitialInsights()
    }

    private func setupInitialInsights() {
    insights = [
    GenieInsight(
    type: .suggestion,
    suggestion: "La méditation du matin semble vous réussir particulièrement bien",
    actionable: GenieAction(title: "Voir les détails") { }
    ),
    GenieInsight(
    type: .pattern,
    suggestion: "Vous êtes plus productif après votre séance de sport",
    actionable: GenieAction(title: "Analyser") { }
    )
    ]
    }

    func sendMessage() {
    guard !inputMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        let userMessage = ChatMessage(id: UUID(), content: inputMessage, isUserMessage: true)
        messages.append(userMessage)

        let currentMessage = inputMessage
        inputMessage = ""

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        let response = self.generateResponse(to: currentMessage)
        let genieMessage = ChatMessage(id: UUID(), content: response, isUserMessage: false)
        self.messages.append(genieMessage)
        }
        }

    private func generateResponse(to question: String) -> String {
    let responses = [
    "Je comprends votre questionnement. Daprès les patterns que jobserve...",
    "Intéressant ! Cela me fait penser à un principe CBT important...",
    "Laissez-moi analyser cela... Je remarque que...",
    "Votre progression est encourageante. Considérez ceci..."
    ]
    return responses.randomElement() ?? "Je réfléchis à votre question..."
    }
    }'

# Features/Genie/GenieView.swift
create_swift_file "$BASE_DIR/Features/Genie/GenieView.swift" '
import SwiftUI

struct GenieView: View {
@StateObject private var viewModel = GenieViewModel()
@State private var showingInsights = false

    var body: some View {
    NavigationView {
    VStack(spacing: 0) {
    GenieHeaderView()
    InsightsScrollView(viewModel: viewModel)
    ChatScrollView(messages: viewModel.messages)
    MessageInputView(
    message: $viewModel.inputMessage,
    onSend: { viewModel.sendMessage() }
    )
    }
    .navigationTitle("Votre Génie CBT")
    .navigationBarTitleDisplayMode(.inline)
    }
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

            Text("Bonjour, je suis votre Génie CBT")
            .font(.headline)
            }
            .padding()
            }
            }

struct InsightsScrollView: View {
@ObservedObject var viewModel: GenieViewModel

    var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
    HStack(spacing: 15) {
    ForEach(viewModel.insights) { insight in
    InsightCard(insight: insight)
    }
    }
    .padding()
    }
    .frame(height: 150)
    }
    }

struct InsightCard: View {
let insight: GenieInsight

    var body: some View {
    VStack(alignment: .leading, spacing: 8) {
    Text(insight.suggestion)
    .font(.subheadline)
    .lineLimit(3)

            if let action = insight.actionable {
            Button(action: action.execute) {
            Text(action.title)
            .font(.caption)
            .bold()
            }
            .buttonStyle(.bordered)
            }
            }
            .padding()
            .frame(width: 200)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(15)
            }
            }

struct ChatScrollView: View {
let messages: [ChatMessage]

    var body: some View {
    ScrollView {
    LazyVStack(spacing: 15) {
    ForEach(messages) { message in
    MessageBubble(message: message)
    }
    }
    .padding()
    }
    }
    }

struct MessageBubble: View {
let message: ChatMessage

    var body: some View {
    HStack {
    if message.isUserMessage {
    Spacer()
    }

            Text(message.content)
            .padding()
            .background(message.isUserMessage ? Color.blue : Color.gray.opacity(0.2))
            .foregroundColor(message.isUserMessage ? .white : .primary)
            .cornerRadius(15)

            if !message.isUserMessage {
            Spacer()
            }
            }
            }
            }

struct MessageInputView: View {
@Binding var message: String
let onSend: () -> Void

    var body: some View {
    HStack(spacing: 12) {
    TextField("Posez une question à votre Génie...", text: $message)
    .textFieldStyle(.roundedBorder)

            Button(action: onSend) {
            Image(systemName: "paperplane.fill")
            .foregroundColor(.white)
            .padding(8)
            .background(Circle().fill(Color.blue))
            }
            .disabled(message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding()
            }
            }'

# ContentView.swift
create_swift_file "$BASE_DIR/ContentView.swift" '
import SwiftUI

struct ContentView: View {
@State private var selectedTab = 1

    var body: some View {
    TabView(selection: $selectedTab) {
    GenieView()
    .tabItem {
    Label("Génie", systemImage: "lamp.desk")
    }
    .tag(0)

            Text("Habits View")
            .tabItem {
            Label("Habitudes", systemImage: "list.bullet")
            }
            .tag(1)

            Text("Stats View")
            .tabItem {
            Label("Statistiques", systemImage: "chart.bar")
            }
            .tag(2)
            }
            }
            }'

# App File
create_swift_file "$BASE_DIR/CBT_Private_AI_GeniusApp.swift" '
import SwiftUI

@main
struct CBT_Private_AI_GeniusApp: App {
var body: some Scene {
WindowGroup {
ContentView()
}
}
}'

echo -e "${BLUE}Structure du projet créée avec succès !${NC}"
echo -e "${GREEN}Vous pouvez maintenant ouvrir le projet dans Xcode${NC}"
