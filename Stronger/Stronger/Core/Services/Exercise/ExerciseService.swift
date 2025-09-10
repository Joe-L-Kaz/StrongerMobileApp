//
//  ExerciseService.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 10/09/2025.
//

protocol ExerciseService {
    func List(
        name: String?,
        primaryMuscleGroup: MuscleGroup?,
        secondaryMuscleGroups: MuscleGroup?,
        exerciseType: ExerciseType?,
        forceType: ForceType?
    ) async throws -> [ExerciseResponse]
}
