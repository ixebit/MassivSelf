// DayProgress.swift
// SwiftData model representing the user's progress for a single program day

import SwiftData
import Foundation

@Model
final class DayProgress {

    // MARK: - Properties

    var dayNumber: Int
    var isCompleted: Bool
    var completedAt: Date?
    var moodRating: Int  // 1–5
    var taskNotes: String

    // MARK: - Relationship

    @Relationship(deleteRule: .cascade)
    var journalEntry: JournalEntry?

    // MARK: - Init

    init(
        dayNumber: Int,
        isCompleted: Bool = false,
        completedAt: Date? = nil,
        moodRating: Int = 0,
        taskNotes: String = ""
    ) {
        self.dayNumber = dayNumber
        self.isCompleted = isCompleted
        self.completedAt = completedAt
        self.moodRating = moodRating
        self.taskNotes = taskNotes
    }
}
