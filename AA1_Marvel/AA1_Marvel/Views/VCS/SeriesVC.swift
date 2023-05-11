//
//  SeriesVC.swift
//  AA1_Marvel
//
//  Created by Albert Pizarro on 11/5/23.
//

import Foundation
import UIKit

class SeriesVC: UIViewController{
    
    @IBOutlet weak var collectionTable: UICollectionView!
    
    public var CurrentHero: Hero?
    
    var series: [Serie] = []
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionTable.dataSource = self
        collectionTable.delegate = self
        
        if let CurrentHero = CurrentHero{
            Api.Marvel.GetSeries(heroId: CurrentHero.id, offset: 0) { series in
                self.series.insert(contentsOf: series, at: self.series.count)
                self.collectionTable.reloadData()
                
            } onError: { error in
                debugPrint(error.heroError.rawValue)
                
            }
            
        }
    }
    
}


extension SeriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? HeroesCollectionCell
        else {
            return UICollectionViewCell()
        }
        
        
        let currentSerie = self.series[indexPath.row]
        
        if let url = currentSerie.thumbnail?.Url{
            cell.collectionImage.SetImageAsync(url: url)
        }

        cell.collectionText.text = currentSerie.title

        
        
        return cell
    }
}
