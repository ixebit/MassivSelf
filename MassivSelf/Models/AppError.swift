// AppError.swift
// Centralized error enum for the entire app

import Foundation

enum AppError: LocalizedError {

    case dataLoadFailed
    case journalSaveFailed
    case notificationPermissionDenied
    case dayContentNotFound(Int)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .dataLoadFailed:
            return String(localized: "error_data_load_failed")
        case .journalSaveFailed:
            return String(localized: "error_journal_save_failed")
        case .notificationPermissionDenied:
            return String(localized: "error_notification_permission_denied")
        case .dayContentNotFound(let day):
            return String(localized: "error_day_content_not_found \(day)")
        case .unknown(let error):
            return error.localizedDescription
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .notificationPermissionDenied:
            return String(localized: "error_recovery_notification")
        default:
            return String(localized: "error_recovery_default")
        }
    }
}
