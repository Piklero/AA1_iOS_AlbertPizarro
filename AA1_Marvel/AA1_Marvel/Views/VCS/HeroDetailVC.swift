//
//  HeroDetailVC.swift
//  AA1_Marvel
//
//  Created by Albert Pizarro on 28/4/23.
//

import Foundation
import UIKit

class HeroDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionTable: UICollectionView!
    
    
    public var CurrentHero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionTable.dataSource = self
        collectionTable.delegate = self
        
        if let CurrentHero = CurrentHero {
            debugPrint(CurrentHero)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? HeroesCollectionCell
        else {
            return UICollectionViewCell()
        }
        
        
        
        
        
        return cell
    }
}

