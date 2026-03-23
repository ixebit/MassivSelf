// Achievement.swift
// SwiftData model for gamification achievements/badges

import SwiftData
import Foundation

// MARK: - Achievement Type Enum

enum AchievementType: String, Codable, CaseIterable {
    case firstDay       = "first_day"
    case threeDays      = "three_days"
    case oneWeek        = "one_week"
    case twoWeeks       = "two_weeks"
    case halfway        = "halfway"
    case threeWeeks     = "three_weeks"
    case finalStretch   = "final_stretch"
    case completed      = "completed"
    case journalStreak  = "journal_streak"
    case moodTracker    = "mood_tracker"

    var titleKey: String {
        "achievement_title_\(rawValue)"
    }

    var descriptionKey: String {
        "achievement_desc_\(rawValue)"
    }

    var sfSymbol: String {
        switch self {
        case .firstDay:      return "star.fill"
        case .threeDays:     return "flame.fill"
        case .oneWeek:       return "7.circle.fill"
        case .twoWeeks:      return "14.circle.fill"
        case .halfway:       return "circle.lefthalf.filled"
        case .threeWeeks:    return "21.circle.fill"
        case .finalStretch:  return "flag.fill"
        case .completed:     return "trophy.fill"
        case .journalStreak: return "book.fill"
        case .moodTracker:   return "heart.fill"
        }
    }

    var requiredDays: Int {
        switch self {
        case .firstDay:      return 1
        case .threeDays:     return 3
        case .oneWeek:       return 7
        case .twoWeeks:      return 14
        case .halfway:       return 15
        case .threeWeeks:    return 21
        case .finalStretch:  return 28
        case .completed:     return 30
        case .journalStreak: return 7
        case .moodTracker:   return 5
        }
    }
}

// MARK: - Achievement Model

@Model
final class Achievement {

    var typeRaw: String
    var unlockedAt: Date?
    var isUnlocked: Bool

    var type: AchievementType {
        AchievementType(rawValue: typeRaw) ?? .firstDay
    }

    init(type: AchievementType) {
        self.typeRaw = type.rawValue
        self.isUnlocked = false
        self.unlockedAt = nil
    }

    func unlock() {
        guard !isUnlocked else { return }
        isUnlocked = true
        unlockedAt = Date()
    }
}
