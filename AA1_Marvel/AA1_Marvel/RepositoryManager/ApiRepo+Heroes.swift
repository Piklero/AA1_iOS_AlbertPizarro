//
//  ApiRepo+Heroes.swift
//  AA1_Marvel
//
//  Created by Albert Pizarro on 28/4/23.
//

import Foundation

extension ApiRepository {
    
    public struct HeroError: Error {
        public enum HeroErrors:String {
            case CantCreateUrlWithString = "Can't create url with string"
            case CantCreateUrl = "Can't create url"
            case Unknown = "Unknown error"
        }
        
        let error: HeroErrors
    }
    
    static func GetHeroes(offset: Int = 0, limit: Int = 20, onSuccess: @escaping ([Hero]) -> (), onError: @escaping (HeroError)->() = {_ in} )
    {
        guard var components = BaseComponents else {
            onError(HeroError(error: .CantCreateUrlWithString))
            return
        }
        
        components.queryItems?.append(URLQueryItem(name: "offset", value: String(offset)))
        components.queryItems?.append(URLQueryItem(name: "limit", value: String(limit)))
        
        guard let url = components.url else {
            onError(HeroError(error: .CantCreateUrl))
            return
        }
        
        let request = URLRequest(url: url)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                
                if error != nil {
                    DispatchQueue.main.async {
                        onError(HeroError(error: .Unknown))
                    }
                    return
                }
                
                guard let heroesResponse = try? JSONDecoder().decode(HerosResponse.self, from: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    onSuccess(heroesResponse.data.results)
                    
                }
            }
            
        }
        task.resume()
        
    }
    
}

