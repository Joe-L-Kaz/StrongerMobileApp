//
//  WorkoutPlanCreateViewModel.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 06/02/2026.
//

import Foundation

@MainActor
final class WorkoutPlanCreateViewModel: ObservableObject{
    @Published var searchText: String = ""
    @Published var exercises: [ExerciseResponse] = []
    @Published var selectedExercises: [Int64] = []
    @Published var failedToLoad: Bool = false
    @Published var failureMessage: String = ""
    
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
                self.failureMessage = "Could not load exercises"
                self.failedToLoad = true
            }
        }
        
        if failedToLoad {
            failedToLoad = false
        }
    }
    
    func onExerciseSelected(
        id: Int64,
        updateExerciseIsSelected: @escaping () -> Void
    ) -> Void {
        if( selectedExercises.contains{ exerciseId in exerciseId == id } ) {
            selectedExercises.removeAll{ exerciseId in exerciseId == id }
        } else {
            selectedExercises.append(id)
        }
        print(selectedExercises)
        updateExerciseIsSelected()
    }
}
