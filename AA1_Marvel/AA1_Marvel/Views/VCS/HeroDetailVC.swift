//
//  HeroDetailVC.swift
//  AA1_Marvel
//
//  Created by Albert Pizarro on 28/4/23.
//

import Foundation
import UIKit

class HeroDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var returnButton: UIButton!
    @IBOutlet var image: MyImageView!
    @IBOutlet var text: UILabel!
    @IBOutlet var descriptionText: UITextView!
    
    
    @IBOutlet weak var collectionTable: UICollectionView!
    
    
    public var CurrentHero: Hero?
    
    var comics: [Comic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionTable.dataSource = self
        collectionTable.delegate = self
        
        if let CurrentHero = CurrentHero {
            self.text.text = CurrentHero.name
            self.descriptionText.text = CurrentHero.description

            if let url = CurrentHero.thumbnail?.Url{
                self.image.SetImageAsync(url: url)
            }
            
            Api.Marvel.GetComics(heroId: CurrentHero.id, offset: 0) { comics in
                self.comics.insert(contentsOf: comics, at: self.comics.count)
                self.collectionTable.reloadData()
                
            } onError: { error in
                debugPrint(error.heroError.rawValue)
            }
        }
        
        returnButton.addTarget(self, action:
            #selector(backToHeroList), for: .touchUpInside)
        
    }
    
    @objc func backToHeroList(){
        self.dismiss(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? HeroesCollectionCell
        else {
            return UICollectionViewCell()
        }
        
        let currentComic = self.comics[indexPath.row]
        
        if let url = currentComic.thumbnail?.Url{
            cell.collectionImage.SetImageAsync(url: url)
        }
        
        cell.collectionText.text = currentComic.title
        
        
        
        
        return cell
    }
}

