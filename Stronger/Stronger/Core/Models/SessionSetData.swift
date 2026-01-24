//
//  SessionSetData.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 24/01/2026.
//

public struct SessionSetData : Codable{
    public let setNumber : Int
    public let reps: Int?
    public let weight: Float?
    public let restTimeSeconds: Int?
    public let cardioTimeSeconds: Int?
}
