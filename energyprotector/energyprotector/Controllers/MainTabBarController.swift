//
//  MainTabBarController.swift
//  energyprotector
//
//  Created by 김수완 on 2020/09/29.
//  Copyright © 2020 김수완. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController{

    // Swipe Gesture Recognizer!!
      override func viewDidLoad() {
          super.viewDidLoad()
          
          delegate = self
   
          // Do any additional setup after loading the view.
      }
   
   
      @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
          
          if gesture.direction == .left {
              if (self.selectedIndex) < 3 {
                  animateToTab(toIndex: self.selectedIndex+1)
              }
          } else if gesture.direction == .right {
              if (self.selectedIndex) > 0 {
                  animateToTab(toIndex: self.selectedIndex-1)
              }
          }
      }
  }
   
  extension MainTabBarController: UITabBarControllerDelegate  {
      func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
          guard let tabViewControllers = tabBarController.viewControllers, let toIndex = tabViewControllers.firstIndex(of: viewController) else {
              return false
          }
          animateToTab(toIndex: toIndex)
          return true
      }
      
      func animateToTab(toIndex: Int) {
          guard let tabViewControllers = viewControllers,
              let selectedVC = selectedViewController else { return }
          
          guard let fromView = selectedVC.view,
              let toView = tabViewControllers[toIndex].view,
              let fromIndex = tabViewControllers.firstIndex(of: selectedVC),
              fromIndex != toIndex else { return }
          
          
          // Add the toView to the tab bar view
          fromView.superview?.addSubview(toView)
          
          // Position toView off screen (to the left/right of fromView)
          let screenWidth = UIScreen.main.bounds.size.width
          let scrollRight = toIndex > fromIndex
          let offset = (scrollRight ? screenWidth : -screenWidth)
          toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)
          
          // Disable interaction during animation
          view.isUserInteractionEnabled = false
          
        UIView.animate(withDuration: 0.5,
                         delay: 0.0,
                         usingSpringWithDamping: 1,
                         initialSpringVelocity: 0,
                         options: .curveEaseOut,
                         animations: {
                          fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y)
                          toView.center = CGPoint(x: toView.center.x - offset, y: toView.center.y)
                          
          }, completion: { finished in
              fromView.removeFromSuperview()
              self.selectedIndex = toIndex
              self.view.isUserInteractionEnabled = true
          })
      }

}
