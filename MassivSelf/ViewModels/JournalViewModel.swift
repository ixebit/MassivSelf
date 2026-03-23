// JournalViewModel.swift
// Manages journal entries — list, creation, editing

import SwiftUI
import SwiftData
import Observation

@Observable
final class JournalViewModel {

    // MARK: - State

    var entries: [JournalEntry] = []
    var editingEntry: JournalEntry? = nil
    var draftContent: String = ""
    var isSaving: Bool = false
    var errorMessage: String? = nil
    var showEditor: Bool = false

    // MARK: - Dependencies

    private let modelContext: ModelContext
    private let appState: AppState

    // MARK: - Init

    init(modelContext: ModelContext, appState: AppState) {
        self.modelContext = modelContext
        self.appState = appState
    }

    // MARK: - Load

    func loadEntries() {
        let descriptor = FetchDescriptor<JournalEntry>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        entries = (try? modelContext.fetch(descriptor)) ?? []
    }

    // MARK: - Computed

    var currentDay: Int {
        appState.currentProgramDay
    }

    var todayEntry: JournalEntry? {
        entries.first { $0.dayNumber == currentDay }
    }

    var hasEntryToday: Bool {
        todayEntry != nil
    }

    // MARK: - Editor

    func openEditorForToday() {
        if let existing = todayEntry {
            editingEntry = existing
            draftContent = existing.content
        } else {
            editingEntry = nil
            draftContent = ""
        }
        showEditor = true
    }

    func openEditor(for entry: JournalEntry) {
        editingEntry = entry
        draftContent = entry.content
        showEditor = true
    }

    // MARK: - Save

    func saveEntry() async {
        guard !draftContent.trimmingCharacters(in: .whitespaces).isEmpty else {
            showEditor = false
            return
        }

        isSaving = true
        defer { isSaving = false }

        if let existing = editingEntry {
            existing.updateContent(draftContent)
        } else {
            let newEntry = JournalEntry(
                dayNumber: currentDay,
                content: draftContent
            )
            modelContext.insert(newEntry)
        }

        do {
            try modelContext.save()
            loadEntries()
            showEditor = false
        } catch {
            errorMessage = AppError.journalSaveFailed.errorDescription
        }
    }

    // MARK: - Delete

    func deleteEntry(_ entry: JournalEntry) {
        modelContext.delete(entry)
        try? modelContext.save()
        loadEntries()
    }
}
