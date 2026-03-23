// cbtgenius/cbtgenius/Core/ML/MonthlySimulator.swift
import Foundation
import SwiftUI

class MonthlySimulator {
    static let shared = MonthlySimulator()

    struct SimulatedDay {
        let date: Date
        let habits: [String: Bool]
        let streaks: [String: Int]
        let message: GenieMessage
    }

    func generateMonthlySimulation() -> [SimulatedDay] {
        var simulation: [SimulatedDay] = []
        let startDate = Date()
        let habits = ["Méditation", "Lecture", "Exercice"]

        for day in 0..<30 {
            let date = Calendar.current.date(byAdding: .day, value: day, to: startDate)!

            let habitStatus = habits.reduce(into: [:]) { dict, habit in
                dict[habit] = Bool.random()
            }

            let streaks = habits.reduce(into: [:]) { dict, habit in
                dict[habit] = Int.random(in: 1...day + 1)
            }

            let message = GenieMessage(
                type: .insight,
                content: "Message quotidien",
                category: nil,
                timestamp: date
            )

            simulation.append(
                SimulatedDay(
                    date: date,
                    habits: habitStatus,
                    streaks: streaks,
                    message: message
                ))
        }

        return simulation
    }
}
