#!/bin/bash

# Couleurs pour le terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Création des dossiers nécessaires
mkdir -p Core/{ML,Storage,Types}
mkdir -p Features/{Genie,Habits,Insights}
mkdir -p Models/ML
mkdir -p Shared/Design

# Fonction pour créer un fichier Swift
create_swift_file() {
local path=$1
cat > "$path" << 'EOF'
$2
EOF
echo -e "${GREEN}Créé/Mis à jour: $path${NC}"
}

# Core/ML/ModelManager.swift
create_swift_file "Core/ML/ModelManager.swift" '
import Foundation

class ModelManager {
    static let shared = ModelManager()
    private(set) var isModelLoaded: Bool = false

    func testModel() -> Bool {
        if let modelPath = Bundle.main.path(forResource: "mistral-instruct-v2", ofType: "gguf") {
            print("✅ Modèle trouvé: \(modelPath)")
            return true
        } else {
            print("❌ Modèle non trouvé")
            return false
        }
    }

    func generateResponse(from input: String) async -> String {
        return "Test: \(input)"
    }
}'

# ContentView.swift
create_swift_file "ContentView.swift" '
import SwiftUI

struct ContentView: View {
    @State private var isModelLoaded = false
    @State private var userInput = ""
    @State private var response = ""

    var body: some View {
        VStack {
            Text("Test du modèle : \(isModelLoaded ? "✅" : "❌")")
                .padding()

            Button("Vérifier modèle") {
                isModelLoaded = ModelManager.shared.testModel()
            }
            .padding()

            TextField("Entrez votre texte", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Envoyer") {
                Task {
                    response = await ModelManager.shared.generateResponse(from: userInput)
                }
            }
            .disabled(!isModelLoaded)
            .padding()

            Text(response)
                .padding()
        }
        .padding()
    }
}'

# CBT_Private_AI_GeniusApp.swift
create_swift_file "CBT_Private_AI_GeniusApp.swift" '
import SwiftUI

@main
struct CBT_Private_AI_GeniusApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}'

# ... Continuer avec les autres fichiers ...

echo -e "${BLUE}Mise à jour des fichiers terminée !${NC}"
