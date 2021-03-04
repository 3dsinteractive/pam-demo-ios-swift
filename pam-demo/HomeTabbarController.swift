//
//  HomeTabbarController.swift
//  pam-demo
//
//  Created by narongrit kanhanoi on 4/3/2564 BE.
//

import UIKit

class HomeTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light
        
        var controller:[UIViewController] = []
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        if let vc = storyBoard.instantiateViewController(identifier: "ProductsListViewController") as? ProductsListViewController {
            controller.append(vc)
        }
        
        if AppData.main.loginUser != nil {
            if let vc = storyBoard.instantiateViewController(identifier: "FavoriteViewController") as? FavoriteViewController {
                vc.initView()
                controller.append(vc)
            }
            
            if let vc = storyBoard.instantiateViewController(identifier: "ShoppingCartViewController") as? ShoppingCartViewController {
                vc.initView()
                controller.append(vc)
            }
        }
        
        if let vc = storyBoard.instantiateViewController(identifier: "ProfileViewController") as? ProfileViewController {
            vc.initView()
            controller.append(vc)
        }
        
        viewControllers = controller
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
