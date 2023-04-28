//
//  ApiRepository.swift
//  AA1_Marvel
//
//  Created by Albert Pizarro on 28/4/23.
//

import Foundation
import CryptoKit

class ApiRepository {
    
    private static let privateKey = "c49b07192da7f07e71f316749459f13b68fb7a7e"
    private static let publicKey = "231aa91dd0f4ec40f9c1bfc5c874fa26"
    
    static var BaseComponents: URLComponents? {
        get {
            guard var urlComponents = URLComponents(string: "https://gateway.marvel.com:443/v1/public/characters")
            else {
                return nil
            }
            
            
            
            let ts = String(Date().timeIntervalSince1970)
            let hash = MD5(string: "\(ts)\(privateKey)\(publicKey)")
            
            
            urlComponents.queryItems = [
                URLQueryItem(name: "apikey", value: "231aa91dd0f4ec40f9c1bfc5c874fa26"),
                URLQueryItem(name: "ts", value: ts),
                URLQueryItem(name: "hash", value: hash),
                
            ]
            return urlComponents
        }
    }
    
}

func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}
    
    

