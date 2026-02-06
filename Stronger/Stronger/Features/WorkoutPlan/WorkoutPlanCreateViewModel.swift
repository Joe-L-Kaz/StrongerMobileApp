//
//  WorkoutPlanCreateViewModel.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 06/02/2026.
//

import Foundation

@MainActor
final class WorkoutPlanCreateViewModel: ObservableObject{
    @Published var planName: String = ""
    @Published var exercises: [ExerciseResponse] = []
    @Published var selectedExercises: [Int64] = []
    @Published var isLoading: Bool = false
    @Published var failedToLoad: Bool = false
    @Published var failureMessage: String = ""
    
    private let exerciseService: ExerciseService
    private let workoutplanService: WorkoutPlanService
    
    init(
        exerciseService: ExerciseService = ExerciseServiceImpl(),
        workoutPlanService: WorkoutPlanService = WorkoutPlanServiceImpl()
    ){
        self.exerciseService = exerciseService
        self.workoutplanService = workoutPlanService
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
    
    func createPlan(onSuccess: @escaping () -> Void) async throws -> Void {
        if(selectedExercises.isEmpty || planName.isEmpty){
            return
        }
        
        do{
            _ = try await workoutplanService.create(name: planName, ids: selectedExercises)
        } catch {
            failureMessage = "Failed to create workout plan"
            return
        }
        onSuccess()
    }
}
