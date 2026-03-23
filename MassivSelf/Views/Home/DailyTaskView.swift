// DailyTaskView.swift
// Displays the daily task with mood check-in and completion button

import SwiftUI

struct DailyTaskView: View {

    // MARK: - Properties

    let content: DayContent
    let isCompleted: Bool
    let selectedMood: Int
    let isCompleting: Bool
    let showCompletionAnimation: Bool
    let onMoodSelected: (Int) -> Void
    let onComplete: () -> Void

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {

            // Task header
            HStack(spacing: 8) {
                Text(String(localized: "home_task_title"))
                    .font(.massiveLabel)
                    .foregroundStyle(Color.secondaryText)
                    .tracking(2)
                    .textCase(.uppercase)

                Spacer()

                if isCompleted {
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 10, weight: .medium))
                        Text(String(localized: "home_task_completed_label"))
                            .font(.massiveLabel)
                    }
                    .foregroundStyle(Color.mossGreen)
                    .transition(.opacity.combined(with: .scale))
                }
            }

            // Task title
            Text(content.taskTitle)
                .font(.massiveHeadline)
                .foregroundStyle(Color.primaryText)

            // Task description
            Text(content.taskDescription)
                .font(.massiveBody)
                .foregroundStyle(Color.secondaryText)
                .lineSpacing(7)
                .fixedSize(horizontal: false, vertical: true)

            if !isCompleted {
                // Divider
                Rectangle()
                    .fill(Color.divider)
                    .frame(height: 0.5)

                // Mood check-in
                MoodCheckInView(
                    selectedMood: selectedMood,
                    onMoodSelected: onMoodSelected
                )

                // Complete button
                completeButton
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isCompleted)
    }

    // MARK: - Complete Button

    private var completeButton: some View {
        Button(action: onComplete) {
            ZStack {
                if isCompleting {
                    ProgressView()
                        .tint(.white)
                } else {
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 13, weight: .medium))
                        Text(String(localized: "home_task_complete_button"))
                            .font(.massiveBody)
                            .tracking(0.5)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(selectedMood > 0 ? Color.inkBlack : Color.stoneGray.opacity(0.3))
            .foregroundStyle(selectedMood > 0 ? .white : Color.secondaryText)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .animation(.easeInOut(duration: 0.2), value: selectedMood)
        }
        .disabled(selectedMood == 0 || isCompleting)
        .accessibilityLabel(String(localized: "home_task_complete_button"))
        .accessibilityHint(
            selectedMood == 0
                ? String(localized: "accessibility_mood_required_hint")
                : String(localized: "accessibility_complete_hint")
        )
        .sensoryFeedback(.success, trigger: showCompletionAnimation)
    }
}

// MARK: - Preview

#Preview("Task — Not Completed") {
    DailyTaskView(
        content: CourseContent.content(for: 1)!,
        isCompleted: false,
        selectedMood: 0,
        isCompleting: false,
        showCompletionAnimation: false,
        onMoodSelected: { _ in },
        onComplete: {}
    )
    .padding(24)
    .background(Color.appBackground)
}

#Preview("Task — Completed") {
    DailyTaskView(
        content: CourseContent.content(for: 1)!,
        isCompleted: true,
        selectedMood: 4,
        isCompleting: false,
        showCompletionAnimation: false,
        onMoodSelected: { _ in },
        onComplete: {}
    )
    .padding(24)
    .background(Color.appBackground)
}
