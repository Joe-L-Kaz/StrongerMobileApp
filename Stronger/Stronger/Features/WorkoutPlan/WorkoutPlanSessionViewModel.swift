//
//  WorkoutPlanSessionViewModel.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 17/01/2026.
//

import Foundation

@MainActor
public final class WorkoutPlanSessionViewModel: ObservableObject {
    @Published var gatheredMetrics: Dictionary<Int64, [ExerciseSet]> = [:]
    @Published var failedToLoad: Bool = false
    @Published var isLoading: Bool = false
    private let sessionService: SessionService
    
    init(workoutPlan: WorkoutPlanResponse, sessionService : SessionService = SessionServiceImpl()){
        self.sessionService = sessionService
        for exercise in workoutPlan.exercises {
            gatheredMetrics.updateValue([ExerciseSet(setNumber: 1)], forKey: exercise.id)
        }
    }
    
    public func addSet(exerciseId: Int64) -> Void {
        var sets: [ExerciseSet] = gatheredMetrics[exerciseId]!
        let setNumber = sets.count + 1
        sets.append(ExerciseSet(setNumber: setNumber))
        gatheredMetrics[exerciseId] = sets
    }
    
    public func removeSet(exerciseId: Int64) -> Void {
        var sets: [ExerciseSet] = gatheredMetrics[exerciseId]!
        if sets.count == 1 {
            return
        }
        sets.removeLast()
        gatheredMetrics[exerciseId] = sets
    }
    
    public func updateSet(exerciseId: Int64, setNumber: Int, newSet: ExerciseSet) -> Void {
        let sets = gatheredMetrics[exerciseId]!
        var newSets: [ExerciseSet] = []
        
        for exerciseSet in sets {
            if newSet.setNumber == exerciseSet.setNumber{
                newSets.append(newSet)
            } else {
                newSets.append(exerciseSet)
            }
        }
        
        gatheredMetrics[exerciseId] = newSets
    }
    
    public func submitSession(onSuccess: @escaping () -> Void) async throws -> Void {
        isLoading = true
        do {
            _ = try await sessionService.Create(sessionData: gatheredMetrics)
        } catch {
            failedToLoad = true
            return
        }
        isLoading = false
        print("success")
        onSuccess()
    }
    
    // Debugging code
    public func printDictionaryToJson(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted]

        let stringKeyed = Dictionary(
            uniqueKeysWithValues: gatheredMetrics.map {
                (String($0.key), $0.value)
            }
        )

        do {
            let data = try encoder.encode(stringKeyed)
            let jsonString = String(decoding: data, as: UTF8.self)
            print(jsonString)
        } catch {
            print("Failed to encode metrics:", error)
        }
    }
}

public struct ExerciseSet : Codable {
    let setNumber: Int
    var repCount: Int = 0
    var weightKg: Float? = 0
    var restTimeSeconds: Int? = nil
}
