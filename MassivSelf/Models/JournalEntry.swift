// JournalEntry.swift
// SwiftData model for daily journal/reflection entries

import SwiftData
import Foundation

@Model
final class JournalEntry {

    // MARK: - Properties

    var id: UUID
    var dayNumber: Int
    var content: String
    var createdAt: Date
    var updatedAt: Date

    // MARK: - Init

    init(dayNumber: Int, content: String = "") {
        self.id = UUID()
        self.dayNumber = dayNumber
        self.content = content
        self.createdAt = Date()
        self.updatedAt = Date()
    }

    // MARK: - Update

    func updateContent(_ newContent: String) {
        self.content = newContent
        self.updatedAt = Date()
    }
}
