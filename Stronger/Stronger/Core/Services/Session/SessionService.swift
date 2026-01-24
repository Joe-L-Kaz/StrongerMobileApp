//
//  SessionService.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 24/01/2026.
//

protocol SessionService {
    func Create(sessionData: Dictionary<Int64, [ExerciseSet]>) async throws -> SessionCreateResponse
}
