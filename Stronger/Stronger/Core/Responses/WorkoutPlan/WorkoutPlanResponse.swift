//
//  WorkoutPlanResponse.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 21/11/2025.
//

public struct WorkoutPlanResponse : Decodable {
    let id : Int
    let name : String
    let exercises: [ExerciseResponse]
}
