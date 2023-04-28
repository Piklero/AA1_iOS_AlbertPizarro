//
//  HeroDetailVC.swift
//  AA1_Marvel
//
//  Created by Albert Pizarro on 28/4/23.
//

import Foundation
import UIKit

class HeroDetailVC: UIViewController {
    public var CurrentHero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let CurrentHero = CurrentHero {
            debugPrint(CurrentHero)
        }
        
    }
}

