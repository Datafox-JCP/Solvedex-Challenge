//
//  DogsViewModel.swift
//  Solvedex Challenge
//
//  Created by Juan Hernandez Pazos on 26/01/24.
//

import Foundation

@MainActor
final class DogsViewModel: ObservableObject {

    @Published var imageUrlList: [String]?
    @Published var numberOfImages: Int = 20

    init() {
        getBreedImageList()
    }

    func getImageList() {
        getBreedImageList()
    }

    func refresh() {
        getBreedImageList()
    }

    func getBreedImageList() {
        let urlString = "\(Constants.randomPugImagesURL)" + "\(numberOfImages)"
        let url = URL(string: urlString)

        if let url = url {
            let request = URLRequest(url: url)
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { data, _, error in
                if error == nil {
                    let decoder = JSONDecoder()

                    if data != nil {
                        do {
                            let decodedResult = try decoder.decode(DogImage.self, from: data!)

                            DispatchQueue.main.async {
                                self.imageUrlList = decodedResult.message!
                            }
                        } catch {
                            print(ErrorCases.invalidResponse.errorDescription!)
                        }
                    } else {
                        print(ErrorCases.invalidData.errorDescription!)
                    }
                } else {
                    print(ErrorCases.invalidUrl.errorDescription!)
                }
            }

            dataTask.resume()
        }
    }
}
