//
//  DogsViewModel.swift
//  Solvedex Challenge
//
//  Created by Juan Hernandez Pazos on 26/01/24.
//

import Foundation

@MainActor
final class DogsViewModel: ObservableObject {
    @Published var Dogs: Dog?
    @Published var dogError: ErrorCases?
    @Published var shouldShowAlert = false
    @Published var isLoading = false
    
    @Published var breedImageUrlList: [String]?
    @Published var imageUrlList: [String]?
    
    
    init() {
        getBreedImageList()
    }
    
    func getImageList() {
        getBreedImageList()
    }
    
    func refresh() {
        getBreedImageList()
    }
    
    func getDogs() async {
        isLoading = true
        do {
            getBreedImageList()
            print(imageUrlList as Any)
            self.Dogs = try await WebService.getDogsData()
            print(Dogs?.message ?? "No data")
            self.isLoading = false
        } catch(let error) {
            dogError = ErrorCases.custom(error: error)
            shouldShowAlert = true
            isLoading = false
        }
    }
    
    func getBreedImageList() {
        let urlString = "\(Constants.randomPugImagesURL)"
        let url = URL(string: urlString)

        if let url = url {
            let request = URLRequest(url: url)
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if data != nil {
                        do {
                            let decodedResult = try decoder.decode(ImageSearch.self, from: data!)
                            
                            DispatchQueue.main.async {
                                var tempUrlList = decodedResult.message!
                                let breedUsed = "pug" // needs breed name here for lookup duplicates
                                let breedNameList = breedUsed.components(separatedBy: .whitespaces) // CharacterSet
                                
                                if breedNameList.count > 1 {
                                    let urlFormat = "\(breedNameList[1])-\(breedNameList[0])"
                                    
//                                    if breedNameList.count > 2 {
//                                        print("Line 81 in breed contains multiple names. Name: \(breedUsed)")
//                                    }
                                    tempUrlList = tempUrlList.filter(){$0.contains(urlFormat) != true}

                                    
                                }
                                self.imageUrlList = tempUrlList
                                                                
                            }
                        }
                        catch {
                            print("Error line 80 in Breed: \(error)")
                        }
                    }
                    else {
                        print("Failed to pull any data from the API, on line 86 in Breed.")
                    }
                    
                }
                else {
                    print("Error occured in Breed, line 85. Failed to pull data from API. Full error: \(error!)")
                }
            }
            
            dataTask.resume()
        }
        
    }
}

