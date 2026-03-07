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
    private static let storageKey = "trainingDaysBitmask"
    private let setDaysService: SetTrainingDaysService
    @Published var isLoading = false
    
    @Published public var trainingDaysBitmask: Int {
        didSet {
            UserDefaults.standard.set(trainingDaysBitmask, forKey: Self.storageKey)
        }
    }

    init(setDaysService : SetTrainingDaysService = SetTrainingDaysServiceImpl()) {
        self.setDaysService = setDaysService
        self.trainingDaysBitmask = UserDefaults.standard.integer(forKey: Self.storageKey)
    }
    
    func setDays() async throws -> Void{
        isLoading = true
        do{
            try await setDaysService.Set(bitMask: trainingDaysBitmask)
        } catch{
            isLoading = false
            throw error
        }
        isLoading = false
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
