// AppState.swift
// Global observable app state — single source of truth for app-wide state

import SwiftUI
import Observation

@Observable
final class AppState {

    // MARK: - Onboarding

    var hasCompletedOnboarding: Bool {
        get { UserDefaults.standard.bool(forKey: Keys.hasCompletedOnboarding) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.hasCompletedOnboarding) }
    }

    // MARK: - User Preferences

    var userName: String {
        get { UserDefaults.standard.string(forKey: Keys.userName) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: Keys.userName) }
    }

    var startDate: Date {
        get {
            if let stored = UserDefaults.standard.object(forKey: Keys.startDate) as? Date {
                return stored
            }
            let today = Date()
            UserDefaults.standard.set(today, forKey: Keys.startDate)
            return today
        }
        set { UserDefaults.standard.set(newValue, forKey: Keys.startDate) }
    }

    var notificationHour: Int {
        get { UserDefaults.standard.integer(forKey: Keys.notificationHour) == 0
            ? 8
            : UserDefaults.standard.integer(forKey: Keys.notificationHour) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.notificationHour) }
    }

    var notificationMinute: Int {
        get { UserDefaults.standard.integer(forKey: Keys.notificationMinute) }
        set { UserDefaults.standard.set(newValue, forKey: Keys.notificationMinute) }
    }

    // MARK: - Offline State

    var isOffline: Bool = false

    // MARK: - Computed

    /// Current day of the 30-day program (1-based, capped at 30)
    var currentProgramDay: Int {
        let calendar = Calendar.current
        let daysSinceStart = calendar.dateComponents(
            [.day],
            from: calendar.startOfDay(for: startDate),
            to: calendar.startOfDay(for: Date())
        ).day ?? 0
        return min(max(daysSinceStart + 1, 1), 30)
    }

    // MARK: - UserDefaults Keys

    private enum Keys {
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
        static let userName = "userName"
        static let startDate = "startDate"
        static let notificationHour = "notificationHour"
        static let notificationMinute = "notificationMinute"
    }
}
