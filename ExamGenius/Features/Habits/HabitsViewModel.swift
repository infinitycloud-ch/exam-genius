import Combine
import Foundation
import SwiftUI

class HabitsViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    @Published var showAddHabit = false
    @Published var showStats = false
    @Published private var completedToday: Set<UUID> = []

    private let userDefaults = UserDefaults.standard
    private var cancellables = Set<AnyCancellable>()

    var todaysHabits: [Habit] {
        habits.filter { habit in
            switch habit.frequency {
            case .daily: return true
            case .weekly: return Calendar.current.isDateInWeekend(Date())
            case .monthly: return Calendar.current.component(.day, from: Date()) == 1
            }
        }
    }

    init() {
        loadHabits()
        loadCompletions()
        setupDailyReset()
    }

    func addHabit(_ habit: Habit) {
        habits.append(habit)
        saveHabits()
    }

    // Ajout des méthodes manquantes
    func isHabitCompletedToday(_ habit: Habit) -> Bool {
        completedToday.contains(habit.id)
    }

    func toggleHabit(_ habit: Habit) {
        if completedToday.contains(habit.id) {
            completedToday.remove(habit.id)
        } else {
            completedToday.insert(habit.id)
            updateStreak(for: habit)
        }
        saveCompletions()
    }

    private func updateStreak(for habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            var updatedHabit = habits[index]
            updatedHabit.streakCount += 1
            updatedHabit.bestStreak = max(updatedHabit.streakCount, updatedHabit.bestStreak)
            habits[index] = updatedHabit
            saveHabits()
        }
    }

    private func loadHabits() {
        if let data = userDefaults.data(forKey: "habits"),
            let decodedHabits = try? JSONDecoder().decode([Habit].self, from: data)
        {
            habits = decodedHabits
        }
    }

    private func saveHabits() {
        if let encoded = try? JSONEncoder().encode(habits) {
            userDefaults.set(encoded, forKey: "habits")
        }
    }

    private func loadCompletions() {
        if let data = userDefaults.data(forKey: "completionsToday"),
            let decoded = try? JSONDecoder().decode(Set<UUID>.self, from: data)
        {
            completedToday = decoded
        }
    }

    private func saveCompletions() {
        if let encoded = try? JSONEncoder().encode(completedToday) {
            userDefaults.set(encoded, forKey: "completionsToday")
        }
    }

    private func setupDailyReset() {
        Timer.publish(every: 3600, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                let calendar = Calendar.current
                if calendar.isDateInTomorrow(Date()) {
                    self?.completedToday.removeAll()
                    self?.saveCompletions()
                }
            }
            .store(in: &cancellables)
    }
}
