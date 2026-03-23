// NotificationService.swift
// Handles all local notification scheduling and permission management

import UserNotifications
import Foundation

@Observable
final class NotificationService {

    // MARK: - Properties

    private let center = UNUserNotificationCenter.current()
    var isAuthorized: Bool = false

    // MARK: - Init

    init() {
        Task {
            await checkAuthorizationStatus()
        }
    }

    // MARK: - Authorization

    /// Requests notification permission from the user
    func requestAuthorization() async throws {
        let granted = try await center.requestAuthorization(
            options: [.alert, .sound, .badge]
        )
        await MainActor.run {
            self.isAuthorized = granted
        }
        if granted {
            await scheduleDailyReminder(hour: 8, minute: 0)
        }
    }

    /// Checks current authorization status without prompting
    func checkAuthorizationStatus() async {
        let settings = await center.notificationSettings()
        await MainActor.run {
            self.isAuthorized = settings.authorizationStatus == .authorized
        }
    }

    // MARK: - Scheduling

    /// Schedules a daily reminder notification at the given time
    func scheduleDailyReminder(hour: Int, minute: Int) async {
        // Remove existing daily reminders before rescheduling
        center.removePendingNotificationRequests(
            withIdentifiers: ["daily_reminder"]
        )

        let content = UNMutableNotificationContent()
        content.title = String(localized: "notification_title")
        content.body = String(localized: "notification_body")
        content.sound = .default
        content.badge = 1

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: "daily_reminder",
            content: content,
            trigger: trigger
        )

        do {
            try await center.add(request)
        } catch {
            print("NotificationService: Failed to schedule — \(error)")
        }
    }

    /// Schedules a one-time achievement notification
    func scheduleAchievementNotification(title: String, body: String) async {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 1,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: "achievement_\(UUID().uuidString)",
            content: content,
            trigger: trigger
        )

        try? await center.add(request)
    }

    /// Cancels all pending notifications
    func cancelAllNotifications() {
        center.removeAllPendingNotificationRequests()
    }

    /// Updates the daily reminder time
    func updateReminderTime(hour: Int, minute: Int) async {
        guard isAuthorized else { return }
        await scheduleDailyReminder(hour: hour, minute: minute)
    }
}
