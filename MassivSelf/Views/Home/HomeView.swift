// HomeView.swift
// Main "Today" screen — daily content, task, mood check-in, affirmation

import SwiftUI
import SwiftData

struct HomeView: View {

    // MARK: - ViewModel

    @State var viewModel: HomeViewModel

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 0) {

                        // MARK: Header
                        HomeHeaderView(
                            greeting: viewModel.greeting,
                            displayName: viewModel.displayName,
                            currentDay: viewModel.currentDay,
                            progressFraction: viewModel.progressFraction
                        )
                        .padding(.horizontal, 24)
                        .padding(.top, 8)
                        .padding(.bottom, 32)

                        // MARK: Divider
                        thinDivider

                        // MARK: Content
                        if let content = viewModel.currentDayContent {
                            VStack(spacing: 0) {

                                // Module label
                                ModuleLabelView(
                                    moduleNumber: content.moduleNumber,
                                    moduleTitle: content.moduleTitle
                                )
                                .padding(.horizontal, 24)
                                .padding(.top, 32)
                                .padding(.bottom, 24)

                                // Theory card
                                TheoryCardView(text: content.theoryText)
                                    .padding(.horizontal, 24)
                                    .padding(.bottom, 24)

                                thinDivider

                                // Daily task
                                DailyTaskView(
                                    content: content,
                                    isCompleted: viewModel.isTaskCompleted,
                                    selectedMood: viewModel.selectedMood,
                                    isCompleting: viewModel.isCompleting,
                                    showCompletionAnimation:
                                        viewModel.showCompletionAnimation,
                                    onMoodSelected: { viewModel.setMood($0) },
                                    onComplete: {
                                        Task { await viewModel.completeTask() }
                                    }
                                )
                                .padding(.horizontal, 24)
                                .padding(.top, 32)
                                .padding(.bottom, 24)

                                thinDivider

                                // Affirmation card
                                AffirmationCardView(
                                    affirmation: content.affirmation
                                )
                                .padding(.horizontal, 24)
                                .padding(.top, 32)
                                .padding(.bottom, 24)

                                thinDivider

                                // Reflection + Journal CTA
                                ReflectionSectionView(
                                    question: content.reflectionQuestion,
                                    hasJournalEntry: false,
                                    onJournalTap: {
                                        viewModel.showJournalEditor = true
                                    }
                                )
                                .padding(.horizontal, 24)
                                .padding(.top, 32)
                                .padding(.bottom, 48)
                            }
                        } else {
                            // Program completed state
                            ProgramCompletedView()
                                .padding(.top, 48)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .navigationBarHidden(true)
            .onAppear { viewModel.loadTodayContent() }
            .sheet(isPresented: $viewModel.showJournalEditor) {
                // Navigate to journal tab instead
                Text("Journal")
            }
        }
    }

    // MARK: - Helpers

    private var thinDivider: some View {
        Rectangle()
            .fill(Color.divider)
            .frame(height: 0.5)
            .padding(.horizontal, 24)
    }
}

// MARK: - Header View

private struct HomeHeaderView: View {

    let greeting: String
    let displayName: String
    let currentDay: Int
    let progressFraction: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            // Greeting
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(greeting)\(displayName)")
                        .font(.massiveCaption)
                        .foregroundStyle(Color.secondaryText)
                        .tracking(1.5)
                        .textCase(.uppercase)

                    Text(String(
                        format: String(localized: "home_day_label"),
                        currentDay
                    ))
                    .font(.massiveTitle)
                    .foregroundStyle(Color.primaryText)
                }

                Spacer()

                // Day number display
                ZStack {
                    Circle()
                        .stroke(Color.divider, lineWidth: 1)
                        .frame(width: 56, height: 56)

                    Circle()
                        .trim(from: 0, to: progressFraction)
                        .stroke(Color.accent, style: StrokeStyle(
                            lineWidth: 1.5,
                            lineCap: .round
                        ))
                        .frame(width: 56, height: 56)
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut(duration: 0.8), value: progressFraction)

                    Text("\(currentDay)")
                        .font(.massiveHeadline)
                        .foregroundStyle(Color.primaryText)
                }
                .accessibilityLabel(String(
                    format: String(localized: "home_day_label"),
                    currentDay
                ))
            }
        }
    }
}

// MARK: - Module Label

private struct ModuleLabelView: View {

    let moduleNumber: Int
    let moduleTitle: String

    var body: some View {
        HStack(spacing: 8) {
            Rectangle()
                .fill(Color.accent)
                .frame(width: 2, height: 14)

            Text("MODULE \(moduleNumber) — \(moduleTitle.uppercased())")
                .font(.massiveLabel)
                .foregroundStyle(Color.secondaryText)
                .tracking(2)

            Spacer()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Module \(moduleNumber): \(moduleTitle)")
    }
}

// MARK: - Theory Card

private struct TheoryCardView: View {

    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "home_theory_title"))
                .font(.massiveLabel)
                .foregroundStyle(Color.secondaryText)
                .tracking(2)
                .textCase(.uppercase)

            Text(text)
                .font(.massiveBody)
                .foregroundStyle(Color.primaryText)
                .lineSpacing(8)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 2))
        .overlay(
            Rectangle()
                .fill(Color.accent)
                .frame(width: 2),
            alignment: .leading
        )
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Reflection Section

private struct ReflectionSectionView: View {

    let question: String
    let hasJournalEntry: Bool
    let onJournalTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(String(localized: "home_reflection_title"))
                .font(.massiveLabel)
                .foregroundStyle(Color.secondaryText)
                .tracking(2)
                .textCase(.uppercase)

            Text(question)
                .font(.massiveBody)
                .foregroundStyle(Color.primaryText)
                .lineSpacing(6)
                .italic()

            Button(action: onJournalTap) {
                HStack(spacing: 8) {
                    Image(systemName: hasJournalEntry ? "book.fill" : "book")
                        .font(.system(size: 14, weight: .light))
                    Text(String(localized: "home_write_journal"))
                        .font(.massiveCaption)
                        .tracking(1)
                }
                .foregroundStyle(Color.accent)
                .frame(height: 44)
            }
            .accessibilityLabel(String(localized: "home_write_journal"))
            .accessibilityHint(String(localized: "accessibility_journal_hint"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Program Completed View

private struct ProgramCompletedView: View {

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "trophy")
                .font(.system(size: 48, weight: .ultraLight))
                .foregroundStyle(Color.accent)

            Text("massively_confident_title")
                .font(.massiveTitle)
                .foregroundStyle(Color.primaryText)
                .multilineTextAlignment(.center)

            Text("massively_confident_subtitle")
                .font(.massiveBody)
                .foregroundStyle(Color.secondaryText)
                .multilineTextAlignment(.center)
                .lineSpacing(6)
                .padding(.horizontal, 32)
        }
        .padding(32)
    }
}

// MARK: - Preview

#Preview("Home — Day 1") {
    let appState = AppState()
    HomeView(
        viewModel: HomeViewModel(
            progressService: ProgressService(
                modelContext: try! ModelContainer(
                    for: DayProgress.self,
                    configurations: ModelConfiguration(isStoredInMemoryOnly: true)
                ).mainContext,
                notificationService: NotificationService()
            ),
            appState: appState
        )
    )
    .environment(appState)
}
