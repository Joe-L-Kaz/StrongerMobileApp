//
//  WorkoutPlanServiceImpl.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 21/11/2025.
//

public struct WorkoutPlanServiceImpl : WorkoutPlanService{
    func List() async throws -> [WorkoutPlanResponse] {
        var response : [WorkoutPlanResponse] = []
        
        do{
            response = try await ApiClient.send(endpoint: "WorkoutPlan/List")
        } catch {
            throw error
        }
        
        return response
    }
}
