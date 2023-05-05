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
        
        Api.Marvel.GetHeroes(onSuccess: { heroes in
            self.heroes.insert(contentsOf: heroes, at: self.heroes.count)
            self.table.reloadData()
        })
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("Hero selected => \(heroes[indexPath.row].name)")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let heroDetailVC = storyboard.instantiateViewController(withIdentifier: "HeroDetail")
            as? HeroDetailVC {
            heroDetailVC.CurrentHero = heroes[indexPath.row]
            heroDetailVC.modalPresentationStyle = .overFullScreen
            self.present(heroDetailVC, animated: true)
        }
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
            
            Api.Marvel.GetHeroes(offset: heroes.count, limit: 30) { heroes in
                self.GetHeroesInProgress = false
                self.heroes.insert(contentsOf: heroes, at: self.heroes.count)
                self.table.reloadData()
            } onError: { error in
                self.GetHeroesInProgress = false
                debugPrint(error.heroError.rawValue)
            }
        }
    }
}



