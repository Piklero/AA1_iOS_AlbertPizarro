//
//  HeroesCollectionCell.swift
//  AA1_Marvel
//
//  Created by Albert Pizarro on 4/5/23.
//

import Foundation
import UIKit

class HeroesCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var collectionText: UILabel!
    
    @IBOutlet weak var collectionImage: MyImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
