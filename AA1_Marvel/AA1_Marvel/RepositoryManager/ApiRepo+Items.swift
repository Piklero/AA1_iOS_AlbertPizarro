//
//  ApiRepo+Items.swift
//  AA1_marvel
//
//  Created by Albert Pizarro on 4/5/23.
//

import Foundation
import UIKit


extension MarvelRepository{
        
    func GetComics(heroId: Int, offset: Int = 0, limit: Int = 20, onSuccess: @escaping ([Comic]) -> (), onError: @escaping (HeroError)->() = {_ in })  {
        
        let marvelComp = MarvelUrlComponents()
        
        marvelComp += .Comics
        marvelComp
            .AddCharacters(heroId)
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
                
                guard let comicResponse = try? JSONDecoder().decode(ComicResponse.self, from: data) else {
                    
                    DispatchQueue.main.async {
                        
                        onError(HeroError(heroError: .CantParseData))
                        
                    }
                    
                    return
                    
                }

                debugPrint(comicResponse)
                DispatchQueue.main.async {
                    
                    onSuccess(comicResponse.data.results)
                    
                }
            }
        }
        
        task.resume()
    }
    
    func GetSeries(heroId: Int, offset: Int = 0, limit: Int = 20, onSuccess: @escaping ([Serie]) -> (), onError: @escaping (HeroError)->() = {_ in })  {
        
        let marvelComp = MarvelUrlComponents()
        
        marvelComp += .Series
        marvelComp
            .AddCharacters(heroId)
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
                
                guard let seriesResponse = try? JSONDecoder().decode(SeriesResponse.self, from: data) else {
                    
                    DispatchQueue.main.async {
                        
                        onError(HeroError(heroError: .CantParseData))
                        
                    }
                    
                    return
                    
                }

                debugPrint(seriesResponse)
                DispatchQueue.main.async {
                    
                    onSuccess(seriesResponse.data.results)
                    
                }
            }
        }
        
        task.resume()
    }
    
    
    func GetStories(heroId: Int, offset: Int = 0, limit: Int = 20, onSuccess: @escaping ([Story]) -> (), onError: @escaping (HeroError)->() = {_ in })  {
        
        let marvelComp = MarvelUrlComponents()
        
        marvelComp += .Stories
        marvelComp
            .AddCharacters(heroId)
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
                
                guard let storiesResponse = try? JSONDecoder().decode(StoriesResponse.self, from: data) else {
                    
                    DispatchQueue.main.async {
                        
                        onError(HeroError(heroError: .CantParseData))
                        
                    }
                    
                    return
                    
                }

                debugPrint(storiesResponse)
                DispatchQueue.main.async {
                    
                    onSuccess(storiesResponse.data.results)
                    
                }
            }
        }
        
        task.resume()
    }
}
