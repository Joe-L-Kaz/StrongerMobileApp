//
//  HttpRequestConfig.swift
//  Stronger
//
//  Created by Joseph Lobo-Kazinczi on 26/07/2025.
//

struct HttpRequestConfig {
    var requiresAuth: Bool = true
    var contentType: String = "application/json"
    var additionalHeaders: [String: String] = [:]
}
