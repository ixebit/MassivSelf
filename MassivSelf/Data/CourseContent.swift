// CourseContent.swift
// Static database of all 30 program days
// Content keys reference Localizable.xcstrings entries

import Foundation

// MARK: - Course Content Registry

enum CourseContent {

    // MARK: - All Days

    static let allDays: [DayContent] = [

        // ─────────────────────────────────────────
        // MODUL 1: FUNDAMENT (Tage 1–5)
        // Basis: Selbstkonzept-Theorie, CBT
        // ─────────────────────────────────────────

        DayContent(
            dayNumber: 1,
            moduleNumber: 1,
            moduleTitleKey: "module_1_title",
            theoryTextKey: "day_1_theory",
            taskTitleKey: "day_1_task_title",
            taskDescriptionKey: "day_1_task_desc",
            reflectionQuestionKey: "day_1_reflection",
            affirmationKey: "day_1_affirmation"
        ),
        DayContent(
            dayNumber: 2,
            moduleNumber: 1,
            moduleTitleKey: "module_1_title",
            theoryTextKey: "day_2_theory",
            taskTitleKey: "day_2_task_title",
            taskDescriptionKey: "day_2_task_desc",
            reflectionQuestionKey: "day_2_reflection",
            affirmationKey: "day_2_affirmation"
        ),
        DayContent(
            dayNumber: 3,
            moduleNumber: 1,
            moduleTitleKey: "module_1_title",
            theoryTextKey: "day_3_theory",
            taskTitleKey: "day_3_task_title",
            taskDescriptionKey: "day_3_task_desc",
            reflectionQuestionKey: "day_3_reflection",
            affirmationKey: "day_3_affirmation"
        ),
        DayContent(
            dayNumber: 4,
            moduleNumber: 1,
            moduleTitleKey: "module_1_title",
            theoryTextKey: "day_4_theory",
            taskTitleKey: "day_4_task_title",
            taskDescriptionKey: "day_4_task_desc",
            reflectionQuestionKey: "day_4_reflection",
            affirmationKey: "day_4_affirmation"
        ),
        DayContent(
            dayNumber: 5,
            moduleNumber: 1,
            moduleTitleKey: "module_1_title",
            theoryTextKey: "day_5_theory",
            taskTitleKey: "day_5_task_title",
            taskDescriptionKey: "day_5_task_desc",
            reflectionQuestionKey: "day_5_reflection",
            affirmationKey: "day_5_affirmation"
        ),

        // ─────────────────────────────────────────
        // MODUL 2: KÖRPER (Tage 6–10)
        // Basis: Embodied Cognition, Amy Cuddy
        // ─────────────────────────────────────────

        DayContent(
            dayNumber: 6,
            moduleNumber: 2,
            moduleTitleKey: "module_2_title",
            theoryTextKey: "day_6_theory",
            taskTitleKey: "day_6_task_title",
            taskDescriptionKey: "day_6_task_desc",
            reflectionQuestionKey: "day_6_reflection",
            affirmationKey: "day_6_affirmation"
        ),
        DayContent(
            dayNumber: 7,
            moduleNumber: 2,
            moduleTitleKey: "module_2_title",
            theoryTextKey: "day_7_theory",
            taskTitleKey: "day_7_task_title",
            taskDescriptionKey: "day_7_task_desc",
            reflectionQuestionKey: "day_7_reflection",
            affirmationKey: "day_7_affirmation"
        ),
        DayContent(
            dayNumber: 8,
            moduleNumber: 2,
            moduleTitleKey: "module_2_title",
            theoryTextKey: "day_8_theory",
            taskTitleKey: "day_8_task_title",
            taskDescriptionKey: "day_8_task_desc",
            reflectionQuestionKey: "day_8_reflection",
            affirmationKey: "day_8_affirmation"
        ),
        DayContent(
            dayNumber: 9,
            moduleNumber: 2,
            moduleTitleKey: "module_2_title",
            theoryTextKey: "day_9_theory",
            taskTitleKey: "day_9_task_title",
            taskDescriptionKey: "day_9_task_desc",
            reflectionQuestionKey: "day_9_reflection",
            affirmationKey: "day_9_affirmation"
        ),
        DayContent(
            dayNumber: 10,
            moduleNumber: 2,
            moduleTitleKey: "module_2_title",
            theoryTextKey: "day_10_theory",
            taskTitleKey: "day_10_task_title",
            taskDescriptionKey: "day_10_task_desc",
            reflectionQuestionKey: "day_10_reflection",
            affirmationKey: "day_10_affirmation"
        ),

        // ─────────────────────────────────────────
        // MODUL 3: GEDANKEN (Tage 11–15)
        // Basis: Aaron Beck CBT, kognitive Umstrukturierung
        // ─────────────────────────────────────────

        DayContent(
            dayNumber: 11,
            moduleNumber: 3,
            moduleTitleKey: "module_3_title",
            theoryTextKey: "day_11_theory",
            taskTitleKey: "day_11_task_title",
            taskDescriptionKey: "day_11_task_desc",
            reflectionQuestionKey: "day_11_reflection",
            affirmationKey: "day_11_affirmation"
        ),
        DayContent(
            dayNumber: 12,
            moduleNumber: 3,
            moduleTitleKey: "module_3_title",
            theoryTextKey: "day_12_theory",
            taskTitleKey: "day_12_task_title",
            taskDescriptionKey: "day_12_task_desc",
            reflectionQuestionKey: "day_12_reflection",
            affirmationKey: "day_12_affirmation"
        ),
        DayContent(
            dayNumber: 13,
            moduleNumber: 3,
            moduleTitleKey: "module_3_title",
            theoryTextKey: "day_13_theory",
            taskTitleKey: "day_13_task_title",
            taskDescriptionKey: "day_13_task_desc",
            reflectionQuestionKey: "day_13_reflection",
            affirmationKey: "day_13_affirmation"
        ),
        DayContent(
            dayNumber: 14,
            moduleNumber: 3,
            moduleTitleKey: "module_3_title",
            theoryTextKey: "day_14_theory",
            taskTitleKey: "day_14_task_title",
            taskDescriptionKey: "day_14_task_desc",
            reflectionQuestionKey: "day_14_reflection",
            affirmationKey: "day_14_affirmation"
        ),
        DayContent(
            dayNumber: 15,
            moduleNumber: 3,
            moduleTitleKey: "module_3_title",
            theoryTextKey: "day_15_theory",
            taskTitleKey: "day_15_task_title",
            taskDescriptionKey: "day_15_task_desc",
            reflectionQuestionKey: "day_15_reflection",
            affirmationKey: "day_15_affirmation"
        ),

        // ─────────────────────────────────────────
        // MODUL 4: HANDLUNG (Tage 16–20)
        // Basis: Bandura Selbstwirksamkeit
        // ─────────────────────────────────────────

        DayContent(
            dayNumber: 16,
            moduleNumber: 4,
            moduleTitleKey: "module_4_title",
            theoryTextKey: "day_16_theory",
            taskTitleKey: "day_16_task_title",
            taskDescriptionKey: "day_16_task_desc",
            reflectionQuestionKey: "day_16_reflection",
            affirmationKey: "day_16_affirmation"
        ),
        DayContent(
            dayNumber: 17,
            moduleNumber: 4,
            moduleTitleKey: "module_4_title",
            theoryTextKey: "day_17_theory",
            taskTitleKey: "day_17_task_title",
            taskDescriptionKey: "day_17_task_desc",
            reflectionQuestionKey: "day_17_reflection",
            affirmationKey: "day_17_affirmation"
        ),
        DayContent(
            dayNumber: 18,
            moduleNumber: 4,
            moduleTitleKey: "module_4_title",
            theoryTextKey: "day_18_theory",
            taskTitleKey: "day_18_task_title",
            taskDescriptionKey: "day_18_task_desc",
            reflectionQuestionKey: "day_18_reflection",
            affirmationKey: "day_18_affirmation"
        ),
        DayContent(
            dayNumber: 19,
            moduleNumber: 4,
            moduleTitleKey: "module_4_title",
            theoryTextKey: "day_19_theory",
            taskTitleKey: "day_19_task_title",
            taskDescriptionKey: "day_19_task_desc",
            reflectionQuestionKey: "day_19_reflection",
            affirmationKey: "day_19_affirmation"
        ),
        DayContent(
            dayNumber: 20,
            moduleNumber: 4,
            moduleTitleKey: "module_4_title",
            theoryTextKey: "day_20_theory",
            taskTitleKey: "day_20_task_title",
            taskDescriptionKey: "day_20_task_desc",
            reflectionQuestionKey: "day_20_reflection",
            affirmationKey: "day_20_affirmation"
        ),

        // ─────────────────────────────────────────
        // MODUL 5: BEZIEHUNGEN (Tage 21–25)
        // Basis: Assertiveness Training, Grenzen setzen
        // ─────────────────────────────────────────

        DayContent(
            dayNumber: 21,
            moduleNumber: 5,
            moduleTitleKey: "module_5_title",
            theoryTextKey: "day_21_theory",
            taskTitleKey: "day_21_task_title",
            taskDescriptionKey: "day_21_task_desc",
            reflectionQuestionKey: "day_21_reflection",
            affirmationKey: "day_21_affirmation"
        ),
        DayContent(
            dayNumber: 22,
            moduleNumber: 5,
            moduleTitleKey: "module_5_title",
            theoryTextKey: "day_22_theory",
            taskTitleKey: "day_22_task_title",
            taskDescriptionKey: "day_22_task_desc",
            reflectionQuestionKey: "day_22_reflection",
            affirmationKey: "day_22_affirmation"
        ),
        DayContent(
            dayNumber: 23,
            moduleNumber: 5,
            moduleTitleKey: "module_5_title",
            theoryTextKey: "day_23_theory",
            taskTitleKey: "day_23_task_title",
            taskDescriptionKey: "day_23_task_desc",
            reflectionQuestionKey: "day_23_reflection",
            affirmationKey: "day_23_affirmation"
        ),
        DayContent(
            dayNumber: 24,
            moduleNumber: 5,
            moduleTitleKey: "module_5_title",
            theoryTextKey: "day_24_theory",
            taskTitleKey: "day_24_task_title",
            taskDescriptionKey: "day_24_task_desc",
            reflectionQuestionKey: "day_24_reflection",
            affirmationKey: "day_24_affirmation"
        ),
        DayContent(
            dayNumber: 25,
            moduleNumber: 5,
            moduleTitleKey: "module_5_title",
            theoryTextKey: "day_25_theory",
            taskTitleKey: "day_25_task_title",
            taskDescriptionKey: "day_25_task_desc",
            reflectionQuestionKey: "day_25_reflection",
            affirmationKey: "day_25_affirmation"
        ),

        // ─────────────────────────────────────────
        // MODUL 6: IDENTITÄT (Tage 26–30)
        // Basis: ACT, VIA Character Strengths, Seligman
        // ─────────────────────────────────────────

        DayContent(
            dayNumber: 26,
            moduleNumber: 6,
            moduleTitleKey: "module_6_title",
            theoryTextKey: "day_26_theory",
            taskTitleKey: "day_26_task_title",
            taskDescriptionKey: "day_26_task_desc",
            reflectionQuestionKey: "day_26_reflection",
            affirmationKey: "day_26_affirmation"
        ),
        DayContent(
            dayNumber: 27,
            moduleNumber: 6,
            moduleTitleKey: "module_6_title",
            theoryTextKey: "day_27_theory",
            taskTitleKey: "day_27_task_title",
            taskDescriptionKey: "day_27_task_desc",
            reflectionQuestionKey: "day_27_reflection",
            affirmationKey: "day_27_affirmation"
        ),
        DayContent(
            dayNumber: 28,
            moduleNumber: 6,
            moduleTitleKey: "module_6_title",
            theoryTextKey: "day_28_theory",
            taskTitleKey: "day_28_task_title",
            taskDescriptionKey: "day_28_task_desc",
            reflectionQuestionKey: "day_28_reflection",
            affirmationKey: "day_28_affirmation"
        ),
        DayContent(
            dayNumber: 29,
            moduleNumber: 6,
            moduleTitleKey: "module_6_title",
            theoryTextKey: "day_29_theory",
            taskTitleKey: "day_29_task_title",
            taskDescriptionKey: "day_29_task_desc",
            reflectionQuestionKey: "day_29_reflection",
            affirmationKey: "day_29_affirmation"
        ),
        DayContent(
            dayNumber: 30,
            moduleNumber: 6,
            moduleTitleKey: "module_6_title",
            theoryTextKey: "day_30_theory",
            taskTitleKey: "day_30_task_title",
            taskDescriptionKey: "day_30_task_desc",
            reflectionQuestionKey: "day_30_reflection",
            affirmationKey: "day_30_affirmation"
        )
    ]

    // MARK: - Lookup

    static func content(for day: Int) -> DayContent? {
        allDays.first { $0.dayNumber == day }
    }

    static func contents(for module: Int) -> [DayContent] {
        allDays.filter { $0.moduleNumber == module }
    }
}
