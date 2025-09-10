//
//  ListExercisesRequest.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 10/09/2025.
//

struct ListExercisesRequest: Codable {
    public let name: String?
    public let primaryMuscleGroup: MuscleGroup?
    public let secondaryMuscleGroups: MuscleGroup?
    public let exerciseType: ExerciseType?
    public let forceType: ForceType?
}
