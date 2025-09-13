//
//  ExercisesViewModel.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 03/09/2025.
//

import Foundation

@MainActor
final class ExercisesViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var exercises: [ExerciseResponse] = []
    
    private let exerciseService: ExerciseService
    
    init(exerciseService: ExerciseService = ExerciseServiceImpl()){
        self.exerciseService = exerciseService
    }
    
    
    
    func getExercises() async throws -> [ExerciseResponse]  {
        do{
            exercises = try await exerciseService.List()
        } catch {
            throw error
        }
        
        print(exercises)
        return []
    }
    
}
