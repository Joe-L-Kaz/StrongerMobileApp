//
//  ExerciseServiceImpl.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 10/09/2025.
//

struct ExerciseServiceImpl: ExerciseService {
    func List() async throws -> [ExerciseResponse] {
        var response : [ExerciseResponse] = []
        
        do{
            response = try await ApiClient.send(endpoint: "Exercise/List")
        } catch {
            throw error
        }
        
        return response
    }
}
