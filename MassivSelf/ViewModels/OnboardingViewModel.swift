// OnboardingViewModel.swift
// Manages onboarding flow state and user input

import SwiftUI
import Observation

@Observable
final class OnboardingViewModel {

    // MARK: - State

    var currentPage: Int = 0
    var userName: String = ""
    var isRequestingNotifications: Bool = false
    var notificationGranted: Bool = false
    var errorMessage: String? = nil

    let totalPages = 4

    // MARK: - Dependencies

    private let notificationService: NotificationService
    private let appState: AppState

    // MARK: - Init

    init(notificationService: NotificationService, appState: AppState) {
        self.notificationService = notificationService
        self.appState = appState
    }

    // MARK: - Navigation

    var canAdvance: Bool {
        currentPage < totalPages - 1
    }

    func advance() {
        guard canAdvance else { return }
        withAnimation(.easeInOut(duration: 0.35)) {
            currentPage += 1
        }
    }

    func skip() {
        withAnimation(.easeInOut(duration: 0.35)) {
            currentPage += 1
        }
    }

    // MARK: - Notifications

    func requestNotifications() async {
        isRequestingNotifications = true
        defer { isRequestingNotifications = false }

        do {
            try await notificationService.requestAuthorization()
            notificationGranted = notificationService.isAuthorized
        } catch {
            errorMessage = AppError.notificationPermissionDenied.errorDescription
        }
        advance()
    }

    // MARK: - Completion

    func completeOnboarding() {
        let trimmed = userName.trimmingCharacters(in: .whitespaces)
        appState.userName = trimmed
        appState.startDate = Date()
        appState.hasCompletedOnboarding = true
    }
}
