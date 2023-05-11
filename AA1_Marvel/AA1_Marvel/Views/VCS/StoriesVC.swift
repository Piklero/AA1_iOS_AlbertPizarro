//
//  SeriesVC.swift
//  AA1_Marvel
//
//  Created by Albert Pizarro on 11/5/23.
//

import Foundation
import UIKit

class StoriesVC: UIViewController{
    
    @IBOutlet weak var collectionTable: UICollectionView!
    
    public var CurrentHero: Hero?
    
    var stories: [Story] = []
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionTable.dataSource = self
        collectionTable.delegate = self
        
        if let CurrentHero = CurrentHero{
            Api.Marvel.GetStories(heroId: CurrentHero.id, offset: 0) { series in
                self.stories.insert(contentsOf: series, at: self.stories.count)
                self.collectionTable.reloadData()
                
            } onError: { error in
                debugPrint(error.heroError.rawValue)
                
            }
            
        }
    }
    
}


extension StoriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? HeroesCollectionCell
        else {
            return UICollectionViewCell()
        }
        
        
        let currentStory = self.stories[indexPath.row]
        
        if let url = currentStory.thumbnail?.Url{
            cell.collectionImage.SetImageAsync(url: url)
        }

        cell.collectionText.text = currentStory.title

        
        
        return cell
    }
}
