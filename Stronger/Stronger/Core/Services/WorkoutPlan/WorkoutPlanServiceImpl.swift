//
//  WorkoutPlanServiceImpl.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 21/11/2025.
//

public struct WorkoutPlanServiceImpl : WorkoutPlanService{
    func list() async throws -> [WorkoutPlanResponse] {
        var response : [WorkoutPlanResponse] = []
        
        do{
            response = try await ApiClient.send(endpoint: "WorkoutPlan/List")
        } catch {
            throw error
        }
        
        return response
    }
    
    func create(name: String, ids: [Int64]) async throws -> WorkoutPlanCreateResponse {
        let request = WorkoutPlanCreateRequest(name: name, associatedExercises: ids)
        
        var response = WorkoutPlanCreateResponse(id: 0)
        
        do{
            response = try await ApiClient.send(endpoint: "WorkoutPlan", requestBody: request)
        } catch {
            throw error
        }
        
        return response
    }
}
