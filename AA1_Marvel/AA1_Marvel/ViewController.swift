//
//  ViewController.swift
//  AA1_Marvel
//
//  Created by Albert Pizarro on 20/4/23.
//

import UIKit
import CryptoKit

class ViewController: UIViewController {

    let privateKey = "c49b07192da7f07e71f316749459f13b68fb7a7e"
    let publicKey = "231aa91dd0f4ec40f9c1bfc5c874fa26"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        guard var urlComponents = URLComponents(string: "https://gateway.marvel.com:443/v1/public/characters") else {
            return
        }
        
        
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(ts)\(privateKey)\(publicKey)")
        
        
        urlComponents.queryItems = [
            URLQueryItem(name: "apikey", value: "231aa91dd0f4ec40f9c1bfc5c874fa26"),
            URLQueryItem(name: "ts", value: ts),
            URLQueryItem(name: "hash", value: hash)
            
        ]
        
        
        guard let url = urlComponents.url else {
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data, let text = String(data: data, encoding: .utf8) {
                print(text)
                
                if let heroesResponse = try?
            }
            
        }
        task.resume()
    }

    
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    struct HerosResponse: Decodable {
        let code: Int
        let status: String
        let data: HeroesData
    }
    
    struct HeroesData: Decodable
    {
        let result: [Hero]
    }

    struct Hero : Decodable{
        let id: Int
        let name: String
        let description: String
    }
}

