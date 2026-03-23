// ProfileView.swift
// User profile — stats, achievements, notification settings, reset

import SwiftUI
import SwiftData

struct ProfileView: View {

    // MARK: - ViewModel

    @State var viewModel: ProfileViewModel

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 0) {

                        // MARK: Header
                        ProfileHeaderView(
                            userName: viewModel.userName,
                            streak: viewModel.streak,
                            completedCount: viewModel.completedCount,
                            progressPercentage: viewModel.progressPercentage
                        )
                        .padding(.horizontal, 24)
                        .padding(.top, 16)
                        .padding(.bottom, 32)

                        thinDivider

                        // MARK: Achievements
                        VStack(alignment: .leading, spacing: 20) {
                            sectionHeader("profile_achievements")

                            AchievementsGridView(
                                achievements: viewModel.achievements
                            )
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 28)
                        .padding(.bottom, 32)

                        thinDivider

                        // MARK: Notification Settings
                        VStack(alignment: .leading, spacing: 20) {
                            sectionHeader("profile_notifications")

                            NotificationSettingsView(
                                hour: $viewModel.notificationHour,
                                minute: $viewModel.notificationMinute,
                                onUpdate: {
                                    Task {
                                        await viewModel.updateNotificationTime()
                                    }
                                }
                            )
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 28)
                        .padding(.bottom, 32)

                        thinDivider

                        // MARK: App Info
                        VStack(spacing: 0) {
                            ProfileLinkRow(
                                icon: "info.circle",
                                title: String(localized: "profile_about")
                            ) {
                                // About sheet — future
                            }

                            thinDivider
                                .padding(.leading, 44)

                            ProfileLinkRow(
                                icon: "lock.shield",
                                title: String(localized: "profile_privacy")
                            ) {
                                // Privacy sheet — future
                            }

                            thinDivider
                                .padding(.leading, 44)

                            // Reset button
                            ProfileLinkRow(
                                icon: "arrow.counterclockwise",
                                title: String(localized: "profile_reset"),
                                isDestructive: true
                            ) {
                                viewModel.showResetConfirmation = true
                            }
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 48)
                    }
                }
                .scrollIndicators(.hidden)
            }
            .navigationBarHidden(true)
            .onAppear { viewModel.loadData() }
            .confirmationDialog(
                String(localized: "profile_reset"),
                isPresented: $viewModel.showResetConfirmation,
                titleVisibility: .visible
            ) {
                Button(
                    String(localized: "button_delete"),
                    role: .destructive
                ) {
                    viewModel.confirmReset()
                }
                Button(
                    String(localized: "button_cancel"),
                    role: .cancel
                ) {}
            } message: {
                Text(String(localized: "profile_reset_confirm"))
            }
        }
    }

    // MARK: - Helpers

    private var thinDivider: some View {
        Rectangle()
            .fill(Color.divider)
            .frame(height: 0.5)
    }

    private func sectionHeader(_ key: String) -> some View {
        Text(String(localized: String.LocalizationValue(key)))
            .font(.massiveLabel)
            .foregroundStyle(Color.secondaryText)
            .tracking(2)
            .textCase(.uppercase)
    }
}

// MARK: - Profile Header

private struct ProfileHeaderView: View {

    let userName: String
    let streak: Int
    let completedCount: Int
    let progressPercentage: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {

            // Name
            VStack(alignment: .leading, spacing: 4) {
                Text(String(localized: "profile_title"))
                    .font(.massiveLabel)
                    .foregroundStyle(Color.secondaryText)
                    .tracking(2)
                    .textCase(.uppercase)

                Text(userName)
                    .font(.massiveTitle)
                    .foregroundStyle(Color.primaryText)
            }

            // Stats row
            HStack(spacing: 0) {
                StatCell(
                    value: "\(streak)",
                    label: String(localized: "profile_streak"),
                    icon: "flame.fill"
                )

                Rectangle()
                    .fill(Color.divider)
                    .frame(width: 0.5, height: 40)

                StatCell(
                    value: "\(completedCount)",
                    label: String(localized: "profile_completed"),
                    icon: "checkmark.circle.fill"
                )

                Rectangle()
                    .fill(Color.divider)
                    .frame(width: 0.5, height: 40)

                StatCell(
                    value: "\(progressPercentage)%",
                    label: String(localized: "journey_title"),
                    icon: "chart.line.uptrend.xyaxis"
                )
            }
            .padding(16)
            .background(Color.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 4))
        }
    }
}

// MARK: - Stat Cell

private struct StatCell: View {

    let value: String
    let label: String
    let icon: String

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .light))
                .foregroundStyle(Color.accent)

            Text(value)
                .font(.massiveHeadline)
                .foregroundStyle(Color.primaryText)

            Text(label)
                .font(.massiveLabel)
                .foregroundStyle(Color.secondaryText)
                .tracking(0.5)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(label): \(value)")
    }
}

// MARK: - Notification Settings

private struct NotificationSettingsView: View {

    @Binding var hour: Int
    @Binding var minute: Int
    let onUpdate: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(String(localized: "profile_notifications"))
                    .font(.massiveBody)
                    .foregroundStyle(Color.primaryText)

                Text(timeString)
                    .font(.massiveCaption)
                    .foregroundStyle(Color.secondaryText)
            }

            Spacer()

            DatePicker(
                "",
                selection: timeBinding,
                displayedComponents: .hourAndMinute
            )
            .labelsHidden()
            .tint(Color.accent)
            .onChange(of: hour) { _, _ in onUpdate() }
            .onChange(of: minute) { _, _ in onUpdate() }
            .accessibilityLabel(String(localized: "profile_notifications"))
        }
        .padding(16)
        .background(Color.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }

    private var timeString: String {
        String(format: "%02d:%02d", hour, minute)
    }

    private var timeBinding: Binding<Date> {
        Binding(
            get: {
                Calendar.current.date(
                    bySettingHour: hour,
                    minute: minute,
                    second: 0,
                    of: Date()
                ) ?? Date()
            },
            set: { newDate in
                hour = Calendar.current.component(.hour, from: newDate)
                minute = Calendar.current.component(.minute, from: newDate)
            }
        )
    }
}

// MARK: - Profile Link Row

private struct ProfileLinkRow: View {

    let icon: String
    let title: String
    var isDestructive: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .light))
                    .foregroundStyle(
                        isDestructive ? .red : Color.secondaryText
                    )
                    .frame(width: 24)

                Text(title)
                    .font(.massiveBody)
                    .foregroundStyle(
                        isDestructive ? .red : Color.primaryText
                    )

                Spacer()

                if !isDestructive {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 11, weight: .light))
                        .foregroundStyle(Color.stoneGray.opacity(0.4))
                }
            }
            .padding(.horizontal, 24)
            .frame(height: 52)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
        .accessibilityAddTraits(.isButton)
    }
}

// MARK: - Preview

#Preview {
    ProfileView(
        viewModel: ProfileViewModel(
            progressService: ProgressService(
                modelContext: try! ModelContainer(
                    for: DayProgress.self,
                    configurations: ModelConfiguration(isStoredInMemoryOnly: true)
                ).mainContext,
                notificationService: NotificationService()
            ),
            notificationService: NotificationService(),
            appState: AppState(),
            modelContext: try! ModelContainer(
                for: Achievement.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            ).mainContext
        )
    )
    .environment(AppState())
}
