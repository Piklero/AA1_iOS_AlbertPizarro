//
//  ApiRepo+Heroes.swift
//  AA1_marvel
//
//  Created by Albert Pizarro on 28/4/23.
//

import Foundation

extension MarvelRepository{
    
    public struct HeroError: Error {
        public enum HeroErrors:String{
            case CantCreateUrlWithString = "Can't create Url with string"
            case CantCreateUrl = "Can't create url"
            case CantParseData = "Can't parse data"
            case Unknown = "Unknown"
        }
        let heroError: HeroErrors
    }
        
    
    func GetHeroes(offset: Int = 0, limit: Int = 20, onSuccess: @escaping ([Hero]) -> (), onError: @escaping (HeroError)->() = {_ in }) {
        
        let marvelComp = MarvelUrlComponents()
        
        marvelComp += .Characters
        marvelComp
            .AddLimit(limit)
            .AddOffset(offset)
        
        
        guard let url = marvelComp.Components.url else{
            onError(HeroError(heroError: .CantCreateUrl))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, respone, error in
            
            if error != nil {
                DispatchQueue.main.async {
                    onError(HeroError(heroError: .Unknown))
                }
                return
            }
            
            if let data = data, let _ = String (data: data, encoding: .utf8){
                
                guard let heroesResponse = try? JSONDecoder().decode(HeroesRespone.self, from: data) else { return }
                //print(heroesResponse)
                
                DispatchQueue.main.async {
                    onSuccess(heroesResponse.data.results)
                    
                }
            }
        }
        
        task.resume()
    }
}
