//
//  WebService.swift
//  Solvedex Challenge
//
//  Created by Juan Hernandez Pazos on 26/01/24.
//

import Foundation

final class WebService {
    
    static func getDogsData() async throws -> Dog {
        let urlString = "\(Constants.randomPugImagesURL)"
        
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, (200...299) ~= response.statusCode else {
            throw ErrorCases.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let dataResponse = try decoder.decode(Dog.self, from: data)
            print(dataResponse)
            return try decoder.decode(Dog.self, from: data)
        } catch {
            print(data)
            throw ErrorCases.invalidData
        }
    }
}
