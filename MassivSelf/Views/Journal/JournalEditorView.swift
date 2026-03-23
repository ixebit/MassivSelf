// JournalEditorView.swift
// Full-screen journal editor with reflection question as prompt

import SwiftUI
import SwiftData

struct JournalEditorView: View {

    // MARK: - ViewModel

    @Bindable var viewModel: JournalViewModel

    // MARK: - State

    @FocusState private var isEditorFocused: Bool
    @Environment(\.dismiss) private var dismiss

    // MARK: - Computed

    private var reflectionQuestion: String {
        CourseContent.content(for: viewModel.currentDay)?
            .reflectionQuestion ?? ""
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()

                VStack(spacing: 0) {

                    // MARK: Top Bar
                    HStack {
                        Button(String(localized: "button_cancel")) {
                            dismiss()
                        }
                        .font(.massiveBody)
                        .foregroundStyle(Color.secondaryText)
                        .frame(height: 44)
                        .accessibilityLabel(String(localized: "button_cancel"))

                        Spacer()

                        Text(String(
                            format: String(localized: "journal_day_label"),
                            viewModel.currentDay
                        ))
                        .font(.massiveLabel)
                        .foregroundStyle(Color.secondaryText)
                        .tracking(2)

                        Spacer()

                        Button(String(localized: "journal_save")) {
                            Task { await viewModel.saveEntry() }
                        }
                        .font(.massiveBody)
                        .foregroundStyle(
                            viewModel.draftContent.isEmpty
                                ? Color.stoneGray
                                : Color.accent
                        )
                        .disabled(viewModel.draftContent.isEmpty || viewModel.isSaving)
                        .frame(height: 44)
                        .accessibilityLabel(String(localized: "journal_save"))
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)

                    // MARK: Divider
                    Rectangle()
                        .fill(Color.divider)
                        .frame(height: 0.5)
                        .padding(.top, 8)

                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {

                            // Reflection prompt
                            if !reflectionQuestion.isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(String(localized: "home_reflection_title"))
                                        .font(.massiveLabel)
                                        .foregroundStyle(Color.secondaryText)
                                        .tracking(2)
                                        .textCase(.uppercase)

                                    Text(reflectionQuestion)
                                        .font(.massiveBody)
                                        .foregroundStyle(Color.secondaryText)
                                        .lineSpacing(6)
                                        .italic()
                                }
                                .padding(.top, 24)
                            }

                            // MARK: Text Editor
                            ZStack(alignment: .topLeading) {
                                if viewModel.draftContent.isEmpty {
                                    Text(String(localized: "journal_placeholder"))
                                        .font(.massiveBody)
                                        .foregroundStyle(Color.stoneGray.opacity(0.5))
                                        .padding(.top, 8)
                                        .allowsHitTesting(false)
                                }

                                TextEditor(text: $viewModel.draftContent)
                                    .font(.massiveBody)
                                    .foregroundStyle(Color.primaryText)
                                    .lineSpacing(7)
                                    .scrollContentBackground(.hidden)
                                    .background(Color.clear)
                                    .focused($isEditorFocused)
                                    .frame(minHeight: 300)
                                    .accessibilityLabel(
                                        String(localized: "journal_placeholder")
                                    )
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 48)
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .navigationBarHidden(true)
            .onAppear { isEditorFocused = true }
        }
        .overlay {
            if viewModel.isSaving {
                Color.black.opacity(0.1)
                    .ignoresSafeArea()
                ProgressView()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    JournalEditorView(
        viewModel: JournalViewModel(
            modelContext: try! ModelContainer(
                for: JournalEntry.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            ).mainContext,
            appState: AppState()
        )
    )
}
