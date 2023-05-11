//
//  HeroDetailVC.swift
//  AA1_Marvel
//
//  Created by Albert Pizarro on 28/4/23.
//

import Foundation
import UIKit

class HeroDetailVC: UIViewController {
    
    @IBOutlet var returnButton: UIButton!
    @IBOutlet var image: MyImageView!
    @IBOutlet var text: UILabel!
    @IBOutlet var descriptionText: UITextView!
    
    
    
    public var CurrentHero: Hero?
    
    var series: [Serie] = []
    
    //variables del PageController
    
    var vcs: [UIViewController] = []
    var pager: UIPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let CurrentHero = CurrentHero {
            self.text.text = CurrentHero.name
            self.descriptionText.text = CurrentHero.description

            if let url = CurrentHero.thumbnail?.Url{
                self.image.SetImageAsync(url: url)
            }
            
           
        }
        
        returnButton.addTarget(self, action:
            #selector(backToHeroList), for: .touchUpInside)
        
        //page controller things
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let firstVC = storyboard.instantiateViewController(withIdentifier: "red") as? ComicVC {
            firstVC.CurrentHero = self.CurrentHero
            vcs.append(firstVC)
        }
        
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "blue") as? SeriesVC {
            secondVC.CurrentHero = self.CurrentHero
            vcs.append(secondVC)
        }
        
        if let thirdVC = storyboard.instantiateViewController(withIdentifier: "yellow") as? StoriesVC {
            thirdVC.CurrentHero = self.CurrentHero
            vcs.append(thirdVC)
        }
        
        pager?.setViewControllers([vcs[0]], direction: .forward, animated: true)
        
        
    }
    
    @objc func backToHeroList(){
        self.dismiss(animated: true)
    }
    
    @IBAction func ComicsPress(_ sender: Any) {
        pager?.setViewControllers([vcs[0]], direction: .forward, animated: true)
    }
    
    
    @IBAction func SeriesPress(_ sender: Any) {
        
        pager?.setViewControllers([vcs[1]], direction: .forward, animated: true)
    }
    
    
    @IBAction func StoriesPress(_ sender: Any) {
        pager?.setViewControllers([vcs[2]], direction: .forward, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        debugPrint(segue.identifier)
        if let pager = segue.destination as? UIPageViewController {
            
            self.pager = pager
            pager.delegate = self
            pager.dataSource = self
            
            
        }
    }
}


extension HeroDetailVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let cur = vcs.firstIndex(of: viewController) else {
            return nil
        }
        
        if cur == 0 {
            return nil
        }
        
        var prev = (cur - 1) % vcs.count
        if prev < 0{
            prev = vcs.count - 1
        }
        return vcs[prev]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let cur = vcs.firstIndex(of: viewController) else {
            return nil
        }
        
        if cur == (vcs.count - 1) {
            return nil
        }
        
        let nxt = abs((cur + 1) % vcs.count)
        return vcs[nxt]
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return vcs.count
    }
    
}
