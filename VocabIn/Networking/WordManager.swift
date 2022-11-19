//
//  WordRequest.swift
//  VocabIn
//
//  Created by bartek on 19/10/2022.
//

import Foundation

//protocol WordManagerDelegate {
//    func didRequestWord(_ wordRequest: WordRequest)
//    func didFailWithError(error: Error)
//}

class WordManager {
    //var entries = [Definitions]()
    //([WordData]), [Definitions])
    func performRequest(word: String, comp: @escaping ([WordData])-> Void) {
        let wordURL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
        let urlString = "\(wordURL)\(word)"
        
        if let url = URL(string: urlString) {
            let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
                (data,response,error) in
                guard let data = data, error == nil else {
                    print("Error occured while accessing data with URL")
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode([WordData].self, from: data)
//                    print(decoded[0].meanings[0].definitions[0])
                    comp(decoded)
                    //comp(decoded, entries.self)
                } catch {
                    print("Error occured while decoding JSON into Swift structure \(error)")
                }
            })
            dataTask.resume()
        }
    }
}


