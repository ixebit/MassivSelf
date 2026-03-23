// ProgressService.swift
// Business logic for tracking progress, streaks, and achievements

import SwiftData
import Foundation

@Observable
final class ProgressService {

    // MARK: - Dependencies

    private let modelContext: ModelContext
    private let notificationService: NotificationService

    // MARK: - Init

    init(modelContext: ModelContext, notificationService: NotificationService) {
        self.modelContext = modelContext
        self.notificationService = notificationService
    }

    // MARK: - Progress Fetching

    /// Returns DayProgress for a specific day, creating it if needed
    func progress(for day: Int) -> DayProgress {
        let descriptor = FetchDescriptor<DayProgress>(
            predicate: #Predicate { $0.dayNumber == day }
        )
        if let existing = try? modelContext.fetch(descriptor).first {
            return existing
        }
        let new = DayProgress(dayNumber: day)
        modelContext.insert(new)
        return new
    }

    /// Returns all completed day progresses sorted by day number
    func allCompletedDays() -> [DayProgress] {
        let descriptor = FetchDescriptor<DayProgress>(
            predicate: #Predicate { $0.isCompleted == true },
            sortBy: [SortDescriptor(\.dayNumber)]
        )
        return (try? modelContext.fetch(descriptor)) ?? []
    }

    /// Returns count of completed days
    func completedDaysCount() -> Int {
        allCompletedDays().count
    }

    // MARK: - Completing a Day

    /// Marks a day as complete and triggers achievement checks
    func completeDay(_ dayNumber: Int, moodRating: Int) async {
        let dayProgress = progress(for: dayNumber)
        guard !dayProgress.isCompleted else { return }

        dayProgress.isCompleted = true
        dayProgress.completedAt = Date()
        dayProgress.moodRating = moodRating

        try? modelContext.save()

        // Check and unlock achievements
        await checkAchievements(completedDay: dayNumber)
    }

    // MARK: - Streak Calculation

    /// Calculates the current consecutive day streak
    func currentStreak() -> Int {
        let completed = allCompletedDays()
        guard !completed.isEmpty else { return 0 }

        var streak = 0
        let checkDay = completed.count

        // Walk backwards from the highest completed day
        for day in stride(from: checkDay, through: 1, by: -1) {
            if completed.contains(where: { $0.dayNumber == day }) {
                streak += 1
            } else {
                break
            }
        }
        return streak
    }

    // MARK: - Achievement Management

    /// Seeds all achievements into the database if not already present
    func seedAchievementsIfNeeded() {
        let descriptor = FetchDescriptor<Achievement>()
        let existing = (try? modelContext.fetch(descriptor)) ?? []

        guard existing.isEmpty else { return }

        for type in AchievementType.allCases {
            let achievement = Achievement(type: type)
            modelContext.insert(achievement)
        }
        try? modelContext.save()
    }

    /// Checks and unlocks any newly earned achievements
    func checkAchievements(completedDay: Int) async {
        let completedCount = completedDaysCount()
        let descriptor = FetchDescriptor<Achievement>(
            predicate: #Predicate { $0.isUnlocked == false }
        )
        let locked = (try? modelContext.fetch(descriptor)) ?? []

        for achievement in locked {
            let shouldUnlock: Bool

            switch achievement.type {
            case .journalStreak:
                shouldUnlock = journalStreakCount() >= 7
            case .moodTracker:
                shouldUnlock = moodTrackerCount() >= 5
            default:
                shouldUnlock = completedCount >= achievement.type.requiredDays
            }

            if shouldUnlock {
                achievement.unlock()
                try? modelContext.save()

                // Fire achievement notification
                let title = String(localized:
                    String.LocalizationValue(achievement.type.titleKey))
                let desc = String(localized:
                    String.LocalizationValue(achievement.type.descriptionKey))
                await notificationService.scheduleAchievementNotification(
                    title: "🏆 \(title)",
                    body: desc
                )
            }
        }
    }

    // MARK: - Journal Stats

    /// Returns count of days with journal entries
    func journalStreakCount() -> Int {
        let descriptor = FetchDescriptor<JournalEntry>()
        let entries = (try? modelContext.fetch(descriptor)) ?? []
        return entries.count
    }

    /// Returns count of days with mood ratings
    func moodTrackerCount() -> Int {
        let descriptor = FetchDescriptor<DayProgress>(
            predicate: #Predicate { $0.moodRating > 0 }
        )
        return ((try? modelContext.fetch(descriptor)) ?? []).count
    }

    // MARK: - Reset

    /// Deletes all progress data — used in Profile reset
    func resetAllProgress() throws {
        try modelContext.delete(model: DayProgress.self)
        try modelContext.delete(model: JournalEntry.self)
        try modelContext.delete(model: Achievement.self)
        try modelContext.save()
        seedAchievementsIfNeeded()
    }
}
