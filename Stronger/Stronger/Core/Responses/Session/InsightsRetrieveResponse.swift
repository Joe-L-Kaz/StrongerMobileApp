//
//  InsightsRetrieveResponse.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 27/02/2026.
//
import Foundation

struct InsightsRetrieveResponse : Decodable{
    let plots : Dictionary<String, [Plot]>
}
