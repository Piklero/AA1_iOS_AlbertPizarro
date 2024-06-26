//
//  HeroesCell.swift
//  AA1_Marvel
//
//  Created by Albert Pizarro on 27/4/23.
//

import Foundation
import UIKit


class HeroesCell: UITableViewCell
{
    
    
    @IBOutlet weak var heroeImage: MyImageView!
    
    @IBOutlet weak var heroeName: UILabel!
    
    @IBOutlet weak var heroeDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

