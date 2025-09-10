//
//  ExerciseResponse.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 10/09/2025.
//

struct ExerciseResponse : Decodable{
    public let Name: String
    public let Description: String
    public let ImagePath: String?
    public let PrimaryMuscleGroup: MuscleGroup
    public let SecondaryMuscleGroup: MuscleGroup?
    public let ExerciseType: ExerciseType
    public let ForceType: ForceType
}
