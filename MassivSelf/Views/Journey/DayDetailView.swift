// DayDetailView.swift
// Detail view for a single day — shown when tapping a day in JourneyView

import SwiftUI
import SwiftData

struct DayDetailView: View {

    // MARK: - Properties

    let day: Int
    @State var viewModel: JourneyViewModel

    // MARK: - Environment

    @Environment(\.dismiss) private var dismiss

    // MARK: - Computed

    private var content: DayContent? {
        viewModel.content(for: day)
    }

    private var progress: DayProgress? {
        viewModel.progress(for: day)
    }

    private var dayState: JourneyViewModel.DayState {
        viewModel.state(for: day)
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            Color.appBackground
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {

                    // MARK: Navigation Bar
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .light))
                                .foregroundStyle(Color.primaryText)
                                .frame(width: 44, height: 44)
                        }
                        .accessibilityLabel(String(localized: "button_back"))

                        Spacer()

                        // Completion badge
                        if dayState == .completed {
                            HStack(spacing: 4) {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 10, weight: .medium))
                                Text(String(localized: "home_task_completed_label"))
                                    .font(.massiveLabel)
                                    .tracking(1)
                            }
                            .foregroundStyle(Color.mossGreen)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                    if let content {
                        VStack(spacing: 0) {

                            // MARK: Day Header
                            VStack(alignment: .leading, spacing: 12) {
                                Text(String(
                                    format: String(localized: "journal_day_label"),
                                    day
                                ))
                                .font(.massiveLabel)
                                .foregroundStyle(Color.secondaryText)
                                .tracking(2)
                                .textCase(.uppercase)

                                Text(content.taskTitle)
                                    .font(.massiveTitle)
                                    .foregroundStyle(Color.primaryText)

                                HStack(spacing: 8) {
                                    Rectangle()
                                        .fill(Color.accent)
                                        .frame(width: 2, height: 12)
                                    Text(content.moduleTitle.uppercased())
                                        .font(.massiveLabel)
                                        .foregroundStyle(Color.secondaryText)
                                        .tracking(2)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                            .padding(.top, 16)
                            .padding(.bottom, 32)

                            thinDivider

                            // MARK: Theory
                            VStack(alignment: .leading, spacing: 12) {
                                sectionLabel("home_theory_title")

                                Text(content.theoryText)
                                    .font(.massiveBody)
                                    .foregroundStyle(Color.primaryText)
                                    .lineSpacing(8)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                            .padding(.top, 28)
                            .padding(.bottom, 28)

                            thinDivider

                            // MARK: Task
                            VStack(alignment: .leading, spacing: 12) {
                                sectionLabel("home_task_title")

                                Text(content.taskDescription)
                                    .font(.massiveBody)
                                    .foregroundStyle(Color.secondaryText)
                                    .lineSpacing(7)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                            .padding(.top, 28)
                            .padding(.bottom, 28)

                            thinDivider

                            // MARK: Affirmation
                            VStack(alignment: .leading, spacing: 12) {
                                sectionLabel("home_affirmation_title")

                                HStack(alignment: .top, spacing: 16) {
                                    Rectangle()
                                        .fill(Color.accent.opacity(0.4))
                                        .frame(width: 1)

                                    Text(content.affirmation)
                                        .font(.massiveAffirmation)
                                        .foregroundStyle(Color.primaryText)
                                        .lineSpacing(6)
                                }
                                .padding(.leading, 4)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                            .padding(.top, 28)
                            .padding(.bottom, 28)

                            thinDivider

                            // MARK: Reflection
                            VStack(alignment: .leading, spacing: 12) {
                                sectionLabel("home_reflection_title")

                                Text(content.reflectionQuestion)
                                    .font(.massiveBody)
                                    .foregroundStyle(Color.primaryText)
                                    .lineSpacing(6)
                                    .italic()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 24)
                            .padding(.top, 28)
                            .padding(.bottom, 28)

                            // MARK: Mood display (if completed)
                            if let progress, progress.moodRating > 0 {
                                thinDivider

                                VStack(alignment: .leading, spacing: 12) {
                                    sectionLabel("home_mood_title")

                                    MoodDisplayView(rating: progress.moodRating)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 24)
                                .padding(.top, 28)
                                .padding(.bottom, 48)
                            } else {
                                Spacer().frame(height: 48)
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .navigationBarHidden(true)
    }

    // MARK: - Helpers

    private var thinDivider: some View {
        Rectangle()
            .fill(Color.divider)
            .frame(height: 0.5)
            .padding(.horizontal, 24)
    }

    private func sectionLabel(_ key: String) -> some View {
        Text(String(localized: String.LocalizationValue(key)))
            .font(.massiveLabel)
            .foregroundStyle(Color.secondaryText)
            .tracking(2)
            .textCase(.uppercase)
    }
}

// MARK: - Mood Display (read-only)

private struct MoodDisplayView: View {

    let rating: Int

    private let symbols = [
        "cloud.rain", "cloud", "sun.min", "sun.max", "sun.max.fill"
    ]

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: symbols[max(0, rating - 1)])
                .font(.system(size: 22, weight: .ultraLight))
                .foregroundStyle(Color.accent)

            Text(moodLabel)
                .font(.massiveBody)
                .foregroundStyle(Color.secondaryText)
        }
        .accessibilityLabel(moodLabel)
    }

    private var moodLabel: String {
        String(localized: String.LocalizationValue("mood_\(rating)"))
    }
}

// MARK: - Preview

#Preview {
    DayDetailView(
        day: 1,
        viewModel: JourneyViewModel(
            progressService: ProgressService(
                modelContext: try! ModelContainer(
                    for: DayProgress.self,
                    configurations: ModelConfiguration(isStoredInMemoryOnly: true)
                ).mainContext,
                notificationService: NotificationService()
            ),
            appState: AppState()
        )
    )
}
