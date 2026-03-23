// cbtgenius/cbtgenius/Features/Habits/AddHabitSheet.swift
import SwiftUI

struct AddHabitSheet: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: HabitsViewModel
    
    @State private var habitName = ""
    @State private var selectedCategory: HabitCategory = .mental
    @State private var selectedFrequency: HabitFrequency = .daily
    @State private var note = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Détails")) {
                    TextField("Nom de l'habitude", text: $habitName)
                    
                    Picker("Catégorie", selection: $selectedCategory) {
                        ForEach(HabitCategory.allCases, id: \.self) { category in
                            Label(
                                category.rawValue.capitalized,
                                systemImage: category.icon
                            ).tag(category)
                        }
                    }
                    
                    Picker("Fréquence", selection: $selectedFrequency) {
                        ForEach(HabitFrequency.allCases, id: \.self) { frequency in
                            Text(frequency.rawValue)
                                .tag(frequency)
                        }
                    }
                }
                
                Section(header: Text("Note (optionnel)")) {
                    TextEditor(text: $note)
                        .frame(height: 100)
                }
                
                Section {
                    HStack {
                        Spacer()
                        Button(action: createHabit) {
                            Text("Créer l'habitude")
                                .bold()
                        }
                        .disabled(habitName.isEmpty)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Nouvelle Habitude")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func createHabit() {
        let habit = Habit(
            name: habitName,
            category: selectedCategory,
            frequency: selectedFrequency,
            notes: note.isEmpty ? [] : [note]
        )
        viewModel.addHabit(habit)
        dismiss()
    }
}
