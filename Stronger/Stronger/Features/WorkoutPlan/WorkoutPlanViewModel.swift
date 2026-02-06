//
//  WorkoutPlanViewModel.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 16/09/2025.
//

import Foundation

@MainActor
public final class WorkoutPlanViewModel : ObservableObject {
    @Published var searchText : String = ""
    @Published var workoutPlans : [WorkoutPlanResponse] = []
    @Published var failedToLoad: Bool = false
    @Published var failureMessage: String = ""
    
    private let workoutPlanService: WorkoutPlanService
    
    init(workoutPlanService: WorkoutPlanService = WorkoutPlanServiceImpl()){
        self.workoutPlanService = workoutPlanService
    }
    
    public func getWorkoutPlans() async throws -> Void{
        do{
            workoutPlans = try await workoutPlanService.list()
        } catch {
            switch error {
            case ApiError.unauthorized:
                throw error
            
            default:
                self.failureMessage = "Could not load plans"
                self.failedToLoad = true
            }
        }
        
        if failedToLoad {
            failedToLoad = false
        }
    }
}
