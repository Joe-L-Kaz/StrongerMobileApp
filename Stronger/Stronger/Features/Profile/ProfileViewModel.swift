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
    // Namespaced key to avoid collisions with other parts of the app that may be using the old key.
    private static let storageKey = "profile.trainingDaysBitmask"
    private static let legacyStorageKey = "trainingDaysBitmask"
    private let setDaysService: SetTrainingDaysService
    @Published var isLoading = false
    
    @Published public var trainingDaysBitmask: Int

    init(setDaysService : SetTrainingDaysService = SetTrainingDaysServiceImpl()) {
        self.setDaysService = setDaysService
        let defaults = UserDefaults.standard

        #if DEBUG
        // One-time reset to clear any previously persisted values so you can re-test from a clean state.
        // To reset again, delete the app from the simulator/device, or set this key back to true.
        let resetKey = "profile.resetTrainingDaysOnce"
        if defaults.object(forKey: resetKey) == nil || defaults.bool(forKey: resetKey) {
            defaults.removeObject(forKey: Self.storageKey)
            defaults.removeObject(forKey: Self.legacyStorageKey)
            defaults.set(false, forKey: resetKey)
            defaults.synchronize()
        }
        #endif

        // Prefer the new namespaced key.
        if defaults.object(forKey: Self.storageKey) != nil {
            self.trainingDaysBitmask = defaults.integer(forKey: Self.storageKey)
        }
        // Otherwise migrate from the legacy key if it exists.
        else if defaults.object(forKey: Self.legacyStorageKey) != nil {
            let legacyValue = defaults.integer(forKey: Self.legacyStorageKey)
            self.trainingDaysBitmask = legacyValue
            defaults.set(legacyValue, forKey: Self.storageKey)
        }
        // Default when nothing exists yet.
        else {
            self.trainingDaysBitmask = 0
        }
    }
    
    func setDays() async throws {
        isLoading = true
        defer { isLoading = false }

        // Persist locally only after a successful save to the API.
        
        do {
            try await setDaysService.Set(bitMask: Int(trainingDaysByteValue))
        } catch {
            print(error)
            throw error
        }
        
        let defaults = UserDefaults.standard
        defaults.set(trainingDaysBitmask, forKey: Self.storageKey)

        // Keep legacy key in sync for now (remove once you're sure nothing else depends on it).
        defaults.set(trainingDaysBitmask, forKey: Self.legacyStorageKey)

        // Force a flush for development/testing so app restarts reflect the latest value.
        defaults.synchronize()
    }

    public struct DayItem: Identifiable {
        public let id = UUID()
        public let name: String
        public let bitIndex: Int

        public init(name: String, bitIndex: Int) {
            self.name = name
            self.bitIndex = bitIndex
        }
    }
    
    // MARK: Day Model

    public let days: [DayItem] = [
        .init(name: "Monday", bitIndex: 0),
        .init(name: "Tuesday", bitIndex: 1),
        .init(name: "Wednesday", bitIndex: 2),
        .init(name: "Thursday", bitIndex: 3),
        .init(name: "Friday", bitIndex: 4),
        .init(name: "Saturday", bitIndex: 5),
        .init(name: "Sunday", bitIndex: 6)
    ]

    // MARK: - Bitmask helpers

    public func isSelected(_ bitIndex: Int) -> Bool {
        let mask = 1 << bitIndex
        return (trainingDaysBitmask & mask) != 0
    }

    public func setSelected(_ bitIndex: Int, _ newValue: Bool) {
        let mask = 1 << bitIndex
        if newValue {
            trainingDaysBitmask |= mask
        } else {
            trainingDaysBitmask &= ~mask
        }
    }

    public func bindingForDay(_ day: DayItem) -> Binding<Bool> {
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

    public var selectedDaysSummary: String {
        let selectedNames = days
            .filter { isSelected($0.bitIndex) }
            .map { $0.name }

        if selectedNames.isEmpty { return "None" }
        if selectedNames.count == days.count { return "Every day" }
        return selectedNames.joined(separator: ", ")
    }

    public var trainingDaysByteValue: UInt8 {
        UInt8(trainingDaysBitmask & 0b0111_1111)
    }

    public var trainingDaysBinaryString: String {
        String(trainingDaysByteValue, radix: 2).leftPad(toLength: 7, withPad: "0")
    }
}

private extension String {
    func leftPad(toLength: Int, withPad character: Character) -> String {
        if count >= toLength { return self }
        return String(repeating: String(character), count: toLength - count) + self
    }
}
