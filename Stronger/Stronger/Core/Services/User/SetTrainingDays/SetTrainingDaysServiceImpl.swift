//
//  SetTrainingDaysServiceImpl.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 07/03/2026.
//

public struct EmptyResponse: Decodable { }

public struct SetTrainingDaysServiceImpl: SetTrainingDaysService {
    func Set(bitMask: Int) async throws {
        // Endpoint expects query string: user?bitmask=<bitmask>
        // This call assumes the ApiClient is already configured with base URL + auth headers.
        do {
            _ = try await ApiClient.send(endpoint: "user?bitmask=\(bitMask)", method: "PUT") as EmptyResponse
        } catch {
            throw error
        }
    }
}
