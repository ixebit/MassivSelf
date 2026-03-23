// Date+Extensions.swift
// Utility extensions for date formatting and comparison

import Foundation

extension Date {

    // MARK: - Formatting

    /// Returns localized short date string e.g. "21. März" / "Mar 21"
    var shortFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }

    /// Returns localized time string e.g. "08:30"
    var timeFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }

    /// Returns day of week string e.g. "Montag" / "Monday"
    var weekdayFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }

    // MARK: - Comparison

    /// Returns true if this date is the same calendar day as another
    func isSameDay(as other: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: other)
    }

    /// Returns true if this date is today
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    /// Returns the start of the day for this date
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    /// Returns number of full days between this date and another
    func daysBetween(_ other: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [.day],
            from: startOfDay,
            to: other.startOfDay
        )
        return abs(components.day ?? 0)
    }
}
