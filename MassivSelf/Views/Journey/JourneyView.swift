// JourneyView.swift
// 30-day overview grid — shows progress across all days and modules

import SwiftUI
import SwiftData

struct JourneyView: View {

    // MARK: - ViewModel

    @State var viewModel: JourneyViewModel

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 0) {

                        // MARK: Header
                        JourneyHeaderView(
                            completedCount: viewModel.completedCount,
                            completionPercentage: viewModel.completionPercentage
                        )
                        .padding(.horizontal, 24)
                        .padding(.top, 16)
                        .padding(.bottom, 32)

                        // MARK: Divider
                        thinDivider

                        // MARK: Module Sections
                        VStack(spacing: 40) {
                            ForEach(1...6, id: \.self) { moduleNumber in
                                ModuleSectionView(
                                    moduleNumber: moduleNumber,
                                    viewModel: viewModel
                                )
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 32)
                        .padding(.bottom, 48)
                    }
                }
                .scrollIndicators(.hidden)
            }
            .navigationBarHidden(true)
            .onAppear { viewModel.loadProgress() }
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

// MARK: - Journey Header

private struct JourneyHeaderView: View {

    let completedCount: Int
    let completionPercentage: Int

    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 8) {
                Text(String(localized: "journey_title"))
                    .font(.massiveTitle)
                    .foregroundStyle(Color.primaryText)

                Text(String(
                    format: String(localized: "journey_days_completed"),
                    completedCount
                ))
                .font(.massiveCaption)
                .foregroundStyle(Color.secondaryText)
                .tracking(1)
            }

            Spacer()

            ProgressRingView(
                progress: Double(completedCount) / 30.0,
                size: 64,
                lineWidth: 1.5
            )
        }
        .accessibilityElement(children: .combine)
    }
}

// MARK: - Module Section

private struct ModuleSectionView: View {

    let moduleNumber: Int
    @State var viewModel: JourneyViewModel

    private var moduleDays: [Int] {
        let start = (moduleNumber - 1) * 5 + 1
        return Array(start...(start + 4))
    }

    private var moduleTitle: String {
        viewModel.moduleTitle(for: moduleDays.first ?? 1)
    }

    private var completedInModule: Int {
        moduleDays.filter { viewModel.completedDays.contains($0) }.count
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            // Module header
            HStack {
                HStack(spacing: 8) {
                    Rectangle()
                        .fill(moduleAccentColor)
                        .frame(width: 2, height: 14)

                    Text("MODULE \(moduleNumber) — \(moduleTitle.uppercased())")
                        .font(.massiveLabel)
                        .foregroundStyle(Color.secondaryText)
                        .tracking(2)
                }

                Spacer()

                Text("\(completedInModule)/5")
                    .font(.massiveLabel)
                    .foregroundStyle(Color.secondaryText)
                    .tracking(1)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel(
                "Module \(moduleNumber): \(moduleTitle), \(completedInModule) of 5 completed"
            )

            // Days grid — 5 days per module in a row
            HStack(spacing: 10) {
                ForEach(moduleDays, id: \.self) { day in
                    NavigationLink {
                        DayDetailView(
                            day: day,
                            viewModel: viewModel
                        )
                    } label: {
                        DayCell(
                            day: day,
                            state: viewModel.state(for: day),
                            accentColor: moduleAccentColor
                        )
                    }
                    .disabled(viewModel.state(for: day) == .locked)
                    .accessibilityLabel(dayAccessibilityLabel(for: day))
                }
            }
        }
    }

    // MARK: - Helpers

    private var moduleAccentColor: Color {
        switch moduleNumber {
        case 1: return .accent
        case 2: return .mossGreen
        case 3: return .deepIndigo
        case 4: return .accent
        case 5: return .mossGreen
        case 6: return .accent
        default: return .accent
        }
    }

    private func dayAccessibilityLabel(for day: Int) -> String {
        let state = viewModel.state(for: day)
        switch state {
        case .completed: return "Day \(day), completed"
        case .current:   return "Day \(day), today"
        case .available: return "Day \(day), available"
        case .locked:    return "Day \(day), locked"
        }
    }
}

// MARK: - Day Cell

private struct DayCell: View {

    let day: Int
    let state: JourneyViewModel.DayState
    let accentColor: Color

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(borderColor, lineWidth: borderWidth)
                )

            VStack(spacing: 4) {
                if state == .completed {
                    Image(systemName: "checkmark")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(accentColor)
                } else if state == .locked {
                    Image(systemName: "lock")
                        .font(.system(size: 10, weight: .light))
                        .foregroundStyle(Color.stoneGray.opacity(0.3))
                } else {
                    Text("\(day)")
                        .font(.massiveCaption)
                        .foregroundStyle(labelColor)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 52)
        .animation(.easeInOut(duration: 0.2), value: state)
    }

    // MARK: - Style Helpers

    private var backgroundColor: Color {
        switch state {
        case .completed: return accentColor.opacity(0.06)
        case .current:   return Color.cardBackground
        case .available: return Color.cardBackground
        case .locked:    return Color.cardBackground.opacity(0.4)
        }
    }

    private var borderColor: Color {
        switch state {
        case .completed: return accentColor.opacity(0.3)
        case .current:   return accentColor
        case .available: return Color.divider
        case .locked:    return Color.divider.opacity(0.3)
        }
    }

    private var borderWidth: CGFloat {
        state == .current ? 1.0 : 0.5
    }

    private var labelColor: Color {
        switch state {
        case .current:   return Color.primaryText
        case .available: return Color.secondaryText
        default:         return Color.stoneGray.opacity(0.3)
        }
    }
}

// MARK: - Preview

#Preview {
    JourneyView(
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
    .environment(AppState())
}
