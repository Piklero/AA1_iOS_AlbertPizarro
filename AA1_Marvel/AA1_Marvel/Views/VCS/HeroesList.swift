//
//  ViewController.swift
//  AA1_Marvel
//
//  Created by Albert Pizarro on 20/4/23.
//

import UIKit


class HeroesListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var table: UITableView!
    
    var heroes: [Hero] = []
    
    var GetHeroesInProgress: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.dataSource = self
        table.delegate = self
        
        GetMoreHeroes()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("Hero selected => \(heroes[indexPath.row].name)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroesCell") as? HeroesCell
        else {
            return UITableViewCell()
        }
        
        let hero = self.heroes[indexPath.row]
        
        cell.heroeName.text = hero.name
        cell.heroeDescription.text = hero.description
        if let imageUrl = hero.thumbnail?.Url{
            cell.heroeImage.SetImageAsync(url: imageUrl)
        }
        
        if indexPath.row + 5 >= heroes.count
        {
           GetMoreHeroes()
        }
        
        return cell
        
    }
    
}

extension HeroesListVC {
    func GetMoreHeroes()
    {
        if !GetHeroesInProgress
        {
            GetHeroesInProgress = true
            
            do {
                try ApiRepository.GetHeroes(offset: heroes.count, limit: 50) { heroes in
                    
                    self.GetHeroesInProgress = false
                    
                    self.heroes.insert(contentsOf: heroes, at: self.heroes.count)
                    self.table.reloadData()
                }
                
            } catch let error as ApiRepository.HeroError {
                debugPrint(error.error)
            }
            catch {
                debugPrint(error)
            }
        }
    }
}

struct HerosResponse: Codable {
    let code: Int
    let status: String
    let data: HeroesData
}

struct HeroesData: Codable
{
    let results: [Hero]
}

struct Hero : Codable{
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail?
}

struct Thumbnail : Codable{
    let path: String
    let `extension`: String
    
    var ImageUrl: String { get { return "\(path).\(`extension`)"}}
    var Url: URL? { get { URL(string: ImageUrl)}}
}


