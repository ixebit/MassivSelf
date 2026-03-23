// JourneyViewModel.swift
// Manages the 30-day overview grid and day detail navigation

import SwiftUI
import SwiftData
import Observation

@Observable
final class JourneyViewModel {

    // MARK: - State

    var selectedDay: Int? = nil
    var completedDays: Set<Int> = []
    var allProgress: [DayProgress] = []

    // MARK: - Dependencies

    private let progressService: ProgressService
    private let appState: AppState

    // MARK: - Init

    init(progressService: ProgressService, appState: AppState) {
        self.progressService = progressService
        self.appState = appState
    }

    // MARK: - Load

    func loadProgress() {
        allProgress = progressService.allCompletedDays()
        completedDays = Set(allProgress.map { $0.dayNumber })
    }

    // MARK: - Computed

    var currentDay: Int {
        appState.currentProgramDay
    }

    var completedCount: Int {
        completedDays.count
    }

    var completionPercentage: Int {
        Int((Double(completedCount) / 30.0) * 100)
    }

    // MARK: - Day State

    enum DayState {
        case completed
        case current
        case available
        case locked
    }

    func state(for day: Int) -> DayState {
        if completedDays.contains(day) { return .completed }
        if day == currentDay { return .current }
        if day <= currentDay { return .available }
        return .locked
    }

    func progress(for day: Int) -> DayProgress? {
        allProgress.first { $0.dayNumber == day }
    }

    func content(for day: Int) -> DayContent? {
        CourseContent.content(for: day)
    }

    // MARK: - Module Info

    func moduleTitle(for day: Int) -> String {
        guard let content = CourseContent.content(for: day) else { return "" }
        return content.moduleTitle
    }

    func moduleNumber(for day: Int) -> Int {
        CourseContent.content(for: day)?.moduleNumber ?? 1
    }
}
