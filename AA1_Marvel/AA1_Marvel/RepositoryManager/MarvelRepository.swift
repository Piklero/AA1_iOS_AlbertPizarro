//
//  MarvelRepository.swift
//  AA1_marvel
//
//  Created by Albert Pizarro on 5/5/23.
//

import Foundation

public class MarvelRepository {
    
    public class MarvelUrlComponents {
        
        private static let privateKey = "c49b07192da7f07e71f316749459f13b68fb7a7e"
        private static let publicKey = "231aa91dd0f4ec40f9c1bfc5c874fa26"
        
        private var components: URLComponents?
        public var Components: URLComponents { get { return components! }}
        
        enum SubPath: String {
            case Characters = "characters"
            case Comics = "comics"
        }
        
        init(){
            
            self.components  = URLComponents(string: "https://gateway.marvel.com:443/v1/public/")
            
            let ts = String(Date().timeIntervalSince1970)
            let hash = Api.MD5(string:"\(ts)\(MarvelUrlComponents.privateKey)\(MarvelUrlComponents.publicKey)")
            
            components?.queryItems = [URLQueryItem(name:"apikey",value:"231aa91dd0f4ec40f9c1bfc5c874fa26"),
                                      URLQueryItem(name:"ts",value:ts),
                                      URLQueryItem(name:"hash",value:hash)]
        }
        
        @discardableResult func AddLimit(_ limit: Int) -> MarvelUrlComponents {
            
            self.components?.queryItems?.append(URLQueryItem(name:"limit",value:"\(limit)"))
            return self
        }
        
        @discardableResult func AddOffset(_ offset: Int) -> MarvelUrlComponents {
            
            self.components?.queryItems?.append(URLQueryItem(name:"offset",value:"\(offset)"))
            return self
        }
        
        @discardableResult func AddToPath(_ subPath: SubPath) -> MarvelUrlComponents {
            self.components?.path += subPath.rawValue
            return self
        }
        
        @discardableResult func AddCharacters(_ characters: Int) -> MarvelUrlComponents {
            self.components?.queryItems?.append(URLQueryItem(name:"characters",value:"\(characters)"))
            return self
        }
        
        static func +=(comp: MarvelUrlComponents, subPath: SubPath){
            comp.AddToPath(subPath)
        }
    }


}

