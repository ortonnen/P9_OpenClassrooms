//
//  WeatherPageViewController.swift
//  Le Baluchon
//
//  Created by Nathalie Ortonne on 21/07/2020.
//  Copyright © 2020 Nathalie Ortonne. All rights reserved.
//

import UIKit

//class WeatherPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        <#code#>
//    }
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.dataSource = self
//
//        // Ceci configure la première vue qui apparaîtra sur notre contrôle de page
////        if let firstViewController = orderedViewControllers.first {
////            setViewControllers([firstViewController],
////                               direction: .forward,
////                               animated: true,
////                               completion: nil)
////        }
//
//        // Do any additional setup after loading the view.
//    }
//
//    func newVc (viewController: String) -> UIViewController {
//        return UIStoryboard (name: "Main", bundle: nil) .instantiateViewController (withIdentifier: viewController)
//    }
//    lazy var commandedViewControllers: [UIViewController] = {
//        return [self.newVc (viewController: "sbFirstWeatherView"),
//                self.newVc (viewController: "sbSecondWeatherView")]
//    } ()
//
////    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
////        guard let viewControllerIndex = WeatherPageViewController.index(of: WeatherViewController) else {
////            return nil
////        }
////
////        let previousIndex = viewControllerIndex - 1
////
////        // L'utilisateur est sur le premier contrôleur de vue et glissé vers la gauche pour boucler
////               // sur le dernier contrôleur de vue.
////        guard previousIndex >= 0 else {
////            return nil
////        }
////
////        guard orderedViewControllers.count > previousIndex else {
////            return nil
////        }
////
////        return orderedViewControllers[previousIndex]
////    }
////
////    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
////        guard let viewControllerIndex = orderedViewControllers.index(of: WeatherViewController) else {
////            return nil
////        }
////
////        let nextIndex = viewControllerIndex + 1
////        let orderedViewControllersCount = orderedViewControllers.count
////
////
////        guard orderedViewControllersCount != nextIndex else {
////            return nil
////        }
////
////        guard orderedViewControllersCount > nextIndex else {
////            return nil
////        }
////
////        return orderedViewControllers[nextIndex]
////    }
//
//}
