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
    @Published var failedToLoad: Bool = true
    @Published var failureMessage: String = "Failed to load exercise plans, swipe down to refresh"
    
    private let exerciseService: ExerciseService
    
    init(exerciseService: ExerciseService = ExerciseServiceImpl()){
        self.exerciseService = exerciseService
    }
    
    
    
    func getExercises() async throws -> Void  {
        do{
            exercises = try await exerciseService.List()
        } catch {
            switch error {
            case ApiError.unauthorized:
                throw error
            
            default:
                self.failureMessage = "Could not load plans"
                self.failedToLoad = true
            }
        }
        
        if failedToLoad == true {
            failedToLoad = false
        }
            
    }
    
}
