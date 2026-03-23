// cbtgenius/cbtgenius/Features/Habits/HabitsView.swift
import SwiftUI

struct HabitsView: View {
@StateObject private var viewModel = HabitsViewModel()
@Environment(\.colorScheme) var colorScheme

    var body: some View {
    NavigationView {
    ScrollView {
    LazyVStack(spacing: 24) {
    if !viewModel.todaysHabits.isEmpty {
    todaySection
    }
    
                    ForEach(HabitCategory.allCases, id: \.self) { category in
                    if !viewModel.habits.filter({ $0.category == category }).isEmpty {
                    categorySection(category)
                    }
                    }
                    }
                    .padding(.vertical)
                    }
                    .navigationTitle("Mes Habitudes")
                    .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.showAddHabit = true }) {
                    Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
                    .font(.title3)
                    }
                    }
                    
                ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { viewModel.showStats = true }) {
                Image(systemName: "chart.bar.fill")
                .foregroundColor(.blue)
                .font(.title3)
                }
                }
                }
                .sheet(isPresented: $viewModel.showAddHabit) {
                AddHabitSheet(viewModel: viewModel)
                }
                .sheet(isPresented: $viewModel.showStats) {
                StatsView(viewModel: viewModel)
                }
                }
                }
                
    private var todaySection: some View {
    VStack(alignment: .leading, spacing: 16) {
    Text("Aujourd'hui")
    .font(.title2)
    .fontWeight(.bold)
    .padding(.horizontal)
    
            ForEach(viewModel.todaysHabits) { habit in
            HabitCard(habit: habit, viewModel: viewModel)
            }
            }
            }
            
    private func categorySection(_ category: HabitCategory) -> some View {
    VStack(alignment: .leading, spacing: 16) {
    HStack {
    Image(systemName: category.icon)
    Text(category.rawValue.capitalized)
    .font(.title2)
    .fontWeight(.bold)
    }
    .padding(.horizontal)
    
            ForEach(viewModel.habits.filter { $0.category == category }) { habit in
            HabitCard(habit: habit, viewModel: viewModel)
            }
            }
            }
            }
