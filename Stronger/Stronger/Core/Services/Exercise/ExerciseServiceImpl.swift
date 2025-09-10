//
//  ExerciseServiceImpl.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 10/09/2025.
//

struct ExerciseServiceImpl: ExerciseService {
    func List(
        name: String? = nil,
        primaryMuscleGroup: MuscleGroup? = nil,
        secondaryMuscleGroups: MuscleGroup? = nil,
        exerciseType: ExerciseType? = nil,
        forceType: ForceType? = nil
    ) async throws -> [ExerciseResponse] {
        let requestBody = ListExercisesRequest(
            name: name,
            primaryMuscleGroup: primaryMuscleGroup,
            secondaryMuscleGroups: secondaryMuscleGroups,
            exerciseType: exerciseType,
            forceType: forceType
        )
        
        var response : [ExerciseResponse] = []
        
        do{
            response = try await ApiClient.send(endpoint: "Exercise/List", requestBody: requestBody)
        } catch {
            throw error
        }
        
        return response
    }
}
