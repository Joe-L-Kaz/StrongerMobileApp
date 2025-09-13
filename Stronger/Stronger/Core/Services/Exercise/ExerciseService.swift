//
//  ExerciseService.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 10/09/2025.
//

protocol ExerciseService {
    func List() async throws -> [ExerciseResponse]
}
