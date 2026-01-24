//
//  SessionServiceImpl.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 24/01/2026.
//

public struct SessionServiceImpl : SessionService {
    func Create(sessionData: Dictionary<Int64, [ExerciseSet]>) async throws -> SessionCreateResponse {
        

        var exercises: [SessionExercise] = []
        
        for (id, sets) in sessionData {
            var sessionDataSets: [SessionSetData] = []
            
            for set in sets {
                sessionDataSets.append(
                    SessionSetData(
                        setNumber: set.setNumber,
                        reps: set.repCount,
                        weight: set.weightKg,
                        restTimeSeconds: set.restTimeSeconds,
                        cardioTimeSeconds: nil
                    )
                )
            }
            
            exercises.append(
                SessionExercise(
                    id: id, sets: sessionDataSets
                )
            )
        }
        var response: SessionCreateResponse = SessionCreateResponse(id: nil)
        let requestBody = SessionCreateRequest(sessionData: SessionData(exercises: exercises)
        )
        do {
            response = try await ApiClient.send(endpoint: "Session", requestBody: requestBody)
        } catch {
            throw error
        }
        return response
    }
}
