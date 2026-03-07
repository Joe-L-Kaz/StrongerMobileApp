//
//  SetTrainingDaysService.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 07/03/2026.
//

protocol SetTrainingDaysService{
    func Set(bitMask: Int) async throws -> Void
}
