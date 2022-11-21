//
//  HomePage.swift
//  MVVMSumit
//
//  Created by Sam-Ranium on 18/10/22.
//

import UIKit

class HomePage: UITabBarController,UITabBarControllerDelegate {
    
    let centerBtn = UIButton.init(type: .custom)
    
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        initialize()
        
        self.tabBar.layer.cornerRadius = 21
        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let newTabBarHeight = defaultTabBarHeight + 16.0
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight
        tabBar.frame = newFrame
        
        
        switch UIScreen.main.nativeBounds.height {
        case 1136,1334,1920,2208:
            //            tabBar.frame.size.height = 60
            //            tabBar.frame.origin.y = view.frame.height - 60
            
            centerBtn.frame.size = CGSize(width: defaultTabBarHeight * 1.2, height: defaultTabBarHeight * 1.2)
            centerBtn.center = CGPoint(x: self.tabBar.center.x , y: self.view.bounds.height - defaultTabBarHeight-10)
            
            break
        default :
            centerBtn.frame.size = CGSize(width: defaultTabBarHeight, height: defaultTabBarHeight)
            centerBtn.center = CGPoint(x: self.tabBar.center.x , y: self.view.bounds.height - defaultTabBarHeight)
        }
        self.centerBtn.layer.cornerRadius = centerBtn.frame.height/2
    }
    
    //    MARK:- Initialization
    func initialize() {
        centerBtn.setTitle("", for: .normal)
        centerBtn.setBackgroundImage(UIImage(named: "Plus"), for: .normal)
        centerBtn.backgroundColor = .white
        centerBtn.clipsToBounds = true
        centerBtn.contentMode = .center
        centerBtn.addTarget(self, action: #selector(handleTouchTabbarCenter), for: .touchUpInside)
        
        self.view.insertSubview(centerBtn, aboveSubview: self.tabBar)
    }
    
    @objc func handleTouchTabbarCenter(sender : UIButton) {
        print("Nacho bhai nacho")
    }
    
    
    
}
