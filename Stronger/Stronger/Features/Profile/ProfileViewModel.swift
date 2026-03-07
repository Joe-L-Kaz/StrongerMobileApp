//
//  ProfileViewModel.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 07/03/2026.
//

import Foundation
import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    private enum StorageKey {
        static let trainingDays = "profile.trainingDaysBitmask"
        static let legacyTrainingDays = "trainingDaysBitmask"
    }
    private let setDaysService: SetTrainingDaysService
    @Published var isLoading = false
    
    @Published var trainingDaysBitmask: Int

    init(setDaysService : SetTrainingDaysService = SetTrainingDaysServiceImpl()) {
        self.setDaysService = setDaysService
        let defaults = UserDefaults.standard

        if defaults.object(forKey: StorageKey.trainingDays) != nil {
            trainingDaysBitmask = defaults.integer(forKey: StorageKey.trainingDays)
        } else if defaults.object(forKey: StorageKey.legacyTrainingDays) != nil {
            let legacyValue = defaults.integer(forKey: StorageKey.legacyTrainingDays)
            trainingDaysBitmask = legacyValue
            defaults.set(legacyValue, forKey: StorageKey.trainingDays)
        } else {
            trainingDaysBitmask = 0
        }
    }
    
    func setDays() async throws {
        isLoading = true
        defer { isLoading = false }

        try await setDaysService.Set(bitMask: Int(trainingDaysByteValue))

        let defaults = UserDefaults.standard
        defaults.set(trainingDaysBitmask, forKey: StorageKey.trainingDays)

        defaults.set(trainingDaysBitmask, forKey: StorageKey.legacyTrainingDays)
    }

    struct DayItem: Identifiable {
        let id = UUID()
        let name: String
        let bitIndex: Int

        init(name: String, bitIndex: Int) {
            self.name = name
            self.bitIndex = bitIndex
        }
    }
    
    // MARK: Day Model

    let days: [DayItem] = [
        .init(name: "Monday", bitIndex: 0),
        .init(name: "Tuesday", bitIndex: 1),
        .init(name: "Wednesday", bitIndex: 2),
        .init(name: "Thursday", bitIndex: 3),
        .init(name: "Friday", bitIndex: 4),
        .init(name: "Saturday", bitIndex: 5),
        .init(name: "Sunday", bitIndex: 6)
    ]

    // MARK: - Bitmask helpers

    func isSelected(_ bitIndex: Int) -> Bool {
        let mask = 1 << bitIndex
        return (trainingDaysBitmask & mask) != 0
    }

    func setSelected(_ bitIndex: Int, _ newValue: Bool) {
        let mask = 1 << bitIndex
        if newValue {
            trainingDaysBitmask |= mask
        } else {
            trainingDaysBitmask &= ~mask
        }
    }

    func bindingForDay(_ day: DayItem) -> Binding<Bool> {
        Binding(
            get: { [weak self] in
                guard let self else { return false }
                return self.isSelected(day.bitIndex)
            },
            set: { [weak self] newValue in
                self?.setSelected(day.bitIndex, newValue)
            }
        )
    }

    var selectedDaysSummary: String {
        let selectedNames = days
            .filter { isSelected($0.bitIndex) }
            .map { $0.name }

        if selectedNames.isEmpty { return "None" }
        if selectedNames.count == days.count { return "Every day" }
        return selectedNames.joined(separator: ", ")
    }

    var trainingDaysByteValue: UInt8 {
        UInt8(trainingDaysBitmask & 0b0111_1111)
    }

    var trainingDaysBinaryString: String {
        String(trainingDaysByteValue, radix: 2).leftPad(toLength: 7, withPad: "0")
    }
}

private extension String {
    func leftPad(toLength: Int, withPad character: Character) -> String {
        if count >= toLength { return self }
        return String(repeating: String(character), count: toLength - count) + self
    }
}
