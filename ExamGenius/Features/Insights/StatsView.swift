// cbtgenius/cbtgenius/Features/Insights/StatsView.swift
import SwiftUI

struct StatsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: HabitsViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section("Vue d'ensemble") {
                    HStack {
                        Label("Habitudes actives", systemImage: "list.bullet.circle.fill")
                        Spacer()
                        Text("\(viewModel.habits.count)")
                            .bold()
                    }
                    
                    HStack {
                        Label("Complétées aujourd'hui", systemImage: "checkmark.circle.fill")
                        Spacer()
                        Text("\(viewModel.habits.filter { viewModel.isHabitCompletedToday($0) }.count)")
                            .bold()
                    }
                }
                
                Section("Par catégorie") {
                    ForEach(HabitCategory.allCases, id: \.self) { category in
                        let habits = viewModel.habits.filter { $0.category == category }
                        if !habits.isEmpty {
                            HStack {
                                Image(systemName: category.icon)
                                    .foregroundColor(.blue)
                                Text(category.rawValue.capitalized)
                                Spacer()
                                Text("\(habits.count)")
                                    .bold()
                            }
                        }
                    }
                }
                
                Section("Meilleures séries") {
                    let sortedHabits = viewModel.habits.sorted { $0.streakCount > $1.streakCount }
                    ForEach(sortedHabits.prefix(3)) { habit in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(habit.name)
                                    .font(.headline)
                                Text(habit.category.rawValue.capitalized)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            if habit.streakCount > 0 {
                                HStack {
                                    Image(systemName: "flame.fill")
                                        .foregroundColor(.orange)
                                    Text("\(habit.streakCount) jours")
                                        .bold()
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Statistiques")
            .toolbar {
                Button("Fermer") {
                    dismiss()
                }
            }
        }
    }
}
