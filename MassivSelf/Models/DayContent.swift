// DayContent.swift
// Static content model for a single program day

import Foundation

struct DayContent {

    // MARK: - Properties

    let dayNumber: Int
    let moduleNumber: Int
    let moduleTitleKey: String
    let theoryTextKey: String
    let taskTitleKey: String
    let taskDescriptionKey: String
    let reflectionQuestionKey: String
    let affirmationKey: String

    // MARK: - Computed Localized Properties

    var moduleTitle: String { String(localized: String.LocalizationValue(moduleTitleKey)) }
    var theoryText: String { String(localized: String.LocalizationValue(theoryTextKey)) }
    var taskTitle: String { String(localized: String.LocalizationValue(taskTitleKey)) }
    var taskDescription: String { String(localized: String.LocalizationValue(taskDescriptionKey)) }
    var reflectionQuestion: String { String(localized: String.LocalizationValue(reflectionQuestionKey)) }
    var affirmation: String { String(localized: String.LocalizationValue(affirmationKey)) }
}
