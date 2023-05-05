//
//  PageContainerTest.swift
//  AA1_Marvel
//
//  Created by Albert Pizarro on 5/5/23.
//

import Foundation
import UIKit

class PagerContainerTest : UIPageViewController {
    
    
    var vcs: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let firstVC = storyboard.instantiateViewController(withIdentifier: "red")
        vcs.append(firstVC)
        vcs.append(storyboard.instantiateViewController(withIdentifier: "blue"))
        vcs.append(storyboard.instantiateViewController(withIdentifier: "yellow"))
        
        self.delegate = self
        self.dataSource = self
        
        self.setViewControllers([firstVC], direction: .forward, animated: true)
    }
    
}

extension PagerContainerTest: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
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
