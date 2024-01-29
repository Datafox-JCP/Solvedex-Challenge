//
//  ErrorCases.swift
//  Solvedex Challenge
//
//  Created by Juan Hernandez Pazos on 23/01/24.
//

import Foundation

enum ErrorCases: LocalizedError {
    case invalidUrl
    case invalidResponse
    case invalidData
    case custom(error: Error)

    var errorDescription: String? {
        switch self {
        case .invalidUrl: return "Invalid URL"

        case .invalidResponse: return "Invalid response"

        case .invalidData: return "Invalid data"

        case .custom(let error):
            return error.localizedDescription
        }
    }
}
