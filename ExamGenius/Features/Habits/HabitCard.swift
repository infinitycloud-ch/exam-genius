// cbtgenius/cbtgenius/Features/Habits/HabitCard.swift
import SwiftUI

struct HabitCard: View {
    let habit: Habit
    @ObservedObject var viewModel: HabitsViewModel
    @State private var showingDetail = false
    @State private var offset: CGFloat = 0
    @State private var isCompleting = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(habit.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text(habit.frequency.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                CompletionButton(
                    isCompleted: viewModel.isHabitCompletedToday(habit),
                    action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            viewModel.toggleHabit(habit)
                        }
                    }
                )
            }
            
            if !habit.notes.isEmpty {
                Text(habit.notes[0])
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            if habit.streakCount > 0 {
                HStack {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.orange)
                    Text("\(habit.streakCount) jours")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
        .padding(.horizontal)
        .offset(x: offset)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if gesture.translation.width < 0 {
                        self.offset = gesture.translation.width
                    }
                }
                .onEnded { _ in
                    if self.offset < -50 {
                        showingDetail = true
                    }
                    withAnimation {
                        self.offset = 0
                    }
                }
        )
        .sheet(isPresented: $showingDetail) {
            HabitDetailView(habit: habit, viewModel: viewModel)
        }
    }
}
