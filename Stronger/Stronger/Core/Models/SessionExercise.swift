//
//  SessionExercise.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 24/01/2026.
//

public struct SessionExercise : Codable{
    public let id: Int64
    public let sets: [SessionSetData]
}
