//
//  ComicVC.swift
//  AA1_Marvel
//
//  Created by Albert Pizarro on 11/5/23.
//

import Foundation
import UIKit

class ComicVC: UIViewController {
    
    @IBOutlet weak var collectionTable: UICollectionView!
    
    public var CurrentHero: Hero?
    
    var comics: [Comic] = []
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionTable.dataSource = self
        collectionTable.delegate = self
        
        if let CurrentHero = CurrentHero{
            Api.Marvel.GetComics(heroId: CurrentHero.id, offset: 0) { comics in
                self.comics.insert(contentsOf: comics, at: self.comics.count)
                self.collectionTable.reloadData()
                
            } onError: { error in
                debugPrint(error.heroError.rawValue)
            }
        }
        
    }
    
}

extension ComicVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return series.count
//    }
    
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
        
        //let currentSerie = self.series[indexPath.row]
        
//        if let url = currentSerie.thumbnail?.Url{
//            cell.collectionImage.SetImageAsync(url: url)
//        }
//
//        cell.collectionText.text = currentSerie.title
//
        
        
        return cell
    }
}
