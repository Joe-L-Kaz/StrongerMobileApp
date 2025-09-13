//
//  ExerciseResponse.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 10/09/2025.
//

struct ExerciseResponse : Decodable{
    public let name: String
    public let description: String
    public let imagePath: String?
    public let primaryMuscleGroup: MuscleGroup
    public let secondaryMuscleGroup: MuscleGroup?
    public let exerciseType: ExerciseType
    public let forceType: ForceType
}
