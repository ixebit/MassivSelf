// ProfileViewModel.swift
// Manages profile screen — stats, achievements, settings, reset

import SwiftUI
import SwiftData
import Observation

@Observable
final class ProfileViewModel {

    // MARK: - State

    var achievements: [Achievement] = []
    var streak: Int = 0
    var completedCount: Int = 0
    var showResetConfirmation: Bool = false
    var notificationHour: Int = 8
    var notificationMinute: Int = 0
    var errorMessage: String? = nil

    // MARK: - Dependencies

    private let progressService: ProgressService
    private let notificationService: NotificationService
    private let appState: AppState
    private let modelContext: ModelContext

    // MARK: - Init

    init(
        progressService: ProgressService,
        notificationService: NotificationService,
        appState: AppState,
        modelContext: ModelContext
    ) {
        self.progressService = progressService
        self.notificationService = notificationService
        self.appState = appState
        self.modelContext = modelContext
    }

    // MARK: - Load

    func loadData() {
        streak = progressService.currentStreak()
        completedCount = progressService.completedDaysCount()
        notificationHour = appState.notificationHour
        notificationMinute = appState.notificationMinute
        loadAchievements()
    }

    private func loadAchievements() {
        let descriptor = FetchDescriptor<Achievement>(
            sortBy: [SortDescriptor(\.typeRaw)]
        )
        achievements = (try? modelContext.fetch(descriptor)) ?? []
    }

    // MARK: - Computed

    var userName: String {
        appState.userName.isEmpty
            ? String(localized: "profile_anonymous")
            : appState.userName
    }

    var unlockedAchievements: [Achievement] {
        achievements.filter { $0.isUnlocked }
    }

    var lockedAchievements: [Achievement] {
        achievements.filter { !$0.isUnlocked }
    }

    var progressPercentage: Int {
        Int((Double(completedCount) / 30.0) * 100)
    }

    // MARK: - Notification Settings

    func updateNotificationTime() async {
        appState.notificationHour = notificationHour
        appState.notificationMinute = notificationMinute
        await notificationService.updateReminderTime(
            hour: notificationHour,
            minute: notificationMinute
        )
    }

    // MARK: - Reset

    func confirmReset() {
        do {
            try progressService.resetAllProgress()
            appState.startDate = Date()
            loadData()
        } catch {
            errorMessage = AppError.dataLoadFailed.errorDescription
        }
    }
}
