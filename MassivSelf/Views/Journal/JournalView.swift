// JournalView.swift
// Lists all journal entries with date and day number

import SwiftUI
import SwiftData

struct JournalView: View {

    // MARK: - ViewModel

    @State var viewModel: JournalViewModel

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()

                VStack(spacing: 0) {

                    // MARK: Header
                    JournalHeaderView(
                        hasEntryToday: viewModel.hasEntryToday,
                        onWriteTap: { viewModel.openEditorForToday() }
                    )
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    .padding(.bottom, 24)

                    // MARK: Divider
                    thinDivider

                    // MARK: Entry List
                    if viewModel.entries.isEmpty {
                        EmptyStateView(
                            icon: "book",
                            title: String(localized: "journal_empty_title"),
                            subtitle: String(localized: "journal_empty_subtitle")
                        )
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(viewModel.entries) { entry in
                                    JournalEntryRow(
                                        entry: entry,
                                        onTap: { viewModel.openEditor(for: entry) },
                                        onDelete: { viewModel.deleteEntry(entry) }
                                    )

                                    thinDivider
                                        .padding(.leading, 24)
                                }
                            }
                            .padding(.top, 8)
                            .padding(.bottom, 48)
                        }
                        .scrollIndicators(.hidden)
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear { viewModel.loadEntries() }
            .sheet(isPresented: $viewModel.showEditor) {
                JournalEditorView(viewModel: viewModel)
            }
        }
    }

    // MARK: - Helpers

    private var thinDivider: some View {
        Rectangle()
            .fill(Color.divider)
            .frame(height: 0.5)
    }
}

// MARK: - Journal Header

private struct JournalHeaderView: View {

    let hasEntryToday: Bool
    let onWriteTap: () -> Void

    var body: some View {
        HStack(alignment: .bottom) {
            Text(String(localized: "journal_title"))
                .font(.massiveTitle)
                .foregroundStyle(Color.primaryText)

            Spacer()

            Button(action: onWriteTap) {
                Image(systemName: hasEntryToday ? "pencil" : "plus")
                    .font(.system(size: 18, weight: .light))
                    .foregroundStyle(Color.accent)
                    .frame(width: 44, height: 44)
            }
            .accessibilityLabel(
                hasEntryToday
                    ? String(localized: "journal_edit_today")
                    : String(localized: "journal_write_today")
            )
        }
    }
}

// MARK: - Journal Entry Row

private struct JournalEntryRow: View {

    let entry: JournalEntry
    let onTap: () -> Void
    let onDelete: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .top, spacing: 16) {

                // Day number badge
                VStack(spacing: 2) {
                    Text(String(
                        format: String(localized: "journal_day_label"),
                        entry.dayNumber
                    ))
                    .font(.massiveLabel)
                    .foregroundStyle(Color.accent)
                    .tracking(1)
                }
                .frame(width: 44)
                .padding(.top, 2)

                // Entry preview
                VStack(alignment: .leading, spacing: 6) {
                    Text(entry.createdAt.shortFormatted)
                        .font(.massiveLabel)
                        .foregroundStyle(Color.secondaryText)
                        .tracking(1)

                    Text(entry.content)
                        .font(.massiveBody)
                        .foregroundStyle(Color.primaryText)
                        .lineLimit(3)
                        .lineSpacing(4)
                        .multilineTextAlignment(.leading)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 11, weight: .light))
                    .foregroundStyle(Color.stoneGray.opacity(0.4))
                    .padding(.top, 4)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 18)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(role: .destructive, action: onDelete) {
                Label(
                    String(localized: "button_delete"),
                    systemImage: "trash"
                )
            }
        }
        .accessibilityLabel(
            "Day \(entry.dayNumber), \(entry.createdAt.shortFormatted)"
        )
        .accessibilityHint(String(localized: "accessibility_journal_row_hint"))
    }
}

// MARK: - Preview

#Preview("Journal — Empty") {
    JournalView(
        viewModel: JournalViewModel(
            modelContext: try! ModelContainer(
                for: JournalEntry.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            ).mainContext,
            appState: AppState()
        )
    )
    .environment(AppState())
}
