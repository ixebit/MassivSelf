// HomeViewModel.swift
// Manages the Today screen — current day content, task completion, mood

import SwiftUI
import SwiftData
import Observation

@Observable
final class HomeViewModel {

    // MARK: - State

    var currentDayContent: DayContent?
    var todayProgress: DayProgress?
    var selectedMood: Int = 0
    var isCompleting: Bool = false
    var showJournalEditor: Bool = false
    var errorMessage: String? = nil
    var showCompletionAnimation: Bool = false

    // MARK: - Dependencies

    private let progressService: ProgressService
    private let appState: AppState

    // MARK: - Init

    init(progressService: ProgressService, appState: AppState) {
        self.progressService = progressService
        self.appState = appState
    }

    // MARK: - Load

    func loadTodayContent() {
        let day = appState.currentProgramDay
        currentDayContent = CourseContent.content(for: day)
        todayProgress = progressService.progress(for: day)
        selectedMood = todayProgress?.moodRating ?? 0
    }

    // MARK: - Computed

    var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12:  return String(localized: "home_greeting_morning")
        case 12..<17: return String(localized: "home_greeting_afternoon")
        default:      return String(localized: "home_greeting_evening")
        }
    }

    var displayName: String {
        appState.userName.isEmpty ? "" : ", \(appState.userName)"
    }

    var currentDay: Int {
        appState.currentProgramDay
    }

    var isTaskCompleted: Bool {
        todayProgress?.isCompleted ?? false
    }

    var progressFraction: Double {
        Double(appState.currentProgramDay) / 30.0
    }

    // MARK: - Actions

    func setMood(_ rating: Int) {
        selectedMood = rating
        todayProgress?.moodRating = rating
    }

    func completeTask() async {
        guard !isTaskCompleted, selectedMood > 0 else { return }

        isCompleting = true
        defer { isCompleting = false }

        await progressService.completeDay(
            appState.currentProgramDay,
            moodRating: selectedMood
        )

        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
            showCompletionAnimation = true
        }

        // Reload after completion
        loadTodayContent()
    }
}
