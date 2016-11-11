//
//  MainPagerViewController.swift
//  Phorum
//
//  Created by Andrew Szot on 11/10/16.
//  Copyright © 2016 Scope. All rights reserved.
//

import UIKit

class MainPagerViewController: UIPageViewController, UIPageViewControllerDataSource {
    static let PRIVATE_EVENTS_VC_ID = "PrivateEventsVCID"
    static let CAMERA_VC_ID = "CameraVCID"
    static let PUBLIC_EVENTS_VC_ID = "PublicEventsVCID"
    
    var pageVCs:[UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let privateEventsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MainPagerViewController.PRIVATE_EVENTS_VC_ID)
        let cameraVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MainPagerViewController.CAMERA_VC_ID)
        let publicEventsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MainPagerViewController.PUBLIC_EVENTS_VC_ID)
        
        self.pageVCs.append(privateEventsVC)
        self.pageVCs.append(cameraVC)
        self.pageVCs.append(publicEventsVC)
        
        dataSource = self
        
        print("Presenting first")
        setViewControllers([self.pageVCs[1]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard
            let viewControllerIndex = self.pageVCs.index(of: viewController)
        else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard self.pageVCs.count > previousIndex else {
            return nil
        }
        
        return self.pageVCs[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard
                let viewControllerIndex = self.pageVCs.index(of: viewController)
            else {
                return nil
            }
            
            let nextIndex = viewControllerIndex + 1
            let pageVCsCount = self.pageVCs.count
            
            guard pageVCsCount != nextIndex else {
                return nil
            }
            
            guard pageVCsCount > nextIndex else {
                return nil
            }
            
            return self.pageVCs[nextIndex]
    }

}
