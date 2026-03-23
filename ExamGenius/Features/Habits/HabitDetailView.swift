import SwiftUI

struct HabitDetailView: View {
    let habit: Habit
    @ObservedObject var viewModel: HabitsViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section("Détails") {
                    LabeledContent("Catégorie", value: habit.category.rawValue.capitalized)
                    LabeledContent("Fréquence", value: habit.frequency.rawValue)
                    LabeledContent("Statut", value: habit.status.rawValue.capitalized)
                }
                
                Section("Statistiques") {
                    HStack {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.orange)
                        Text("Série actuelle")
                        Spacer()
                        Text("\(habit.streakCount) jours")
                            .bold()
                    }
                    
                    HStack {
                        Image(systemName: "trophy.fill")
                            .foregroundColor(.yellow)
                        Text("Meilleure série")
                        Spacer()
                        Text("\(habit.bestStreak) jours")
                            .bold()
                    }
                }
                
                Section("Notes") {
                    if habit.notes.isEmpty {
                        Text("Aucune note")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(habit.notes, id: \.self) { note in
                            Text(note)
                        }
                    }
                }
                
                Section("Historique récent") {
                    if habit.completions.isEmpty {
                        Text("Aucune completion")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(habit.completions.prefix(5)) { completion in
                            HStack {
                                Text(completion.date, format: .dateTime)
                                if let note = completion.note {
                                    Text(note)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(habit.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Fermer") {
                        dismiss()
                    }
                }
            }
        }
    }
}
