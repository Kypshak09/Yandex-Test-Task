//
//  TabBarViewController.swift
//  Yandex Test Task
//
//  Created by Amir Zhunussov on 31.01.2023.
//

import UIKit

class tabBarViewController: UITabBarController{

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        
        
        let stocks = createTabBar(vc: ViewController(), itemImage: "line.3.horizontal", itemName: "Stocks")
        let favourite = createTabBar(vc: FavouriteViewController(), itemImage: "star.fill", itemName: "Favourite")
        viewControllers = [stocks,favourite]
        
    }
    
  


    func createTabBar(vc: UIViewController, itemImage: String, itemName: String) -> UIViewController {
        let controller = UINavigationController(rootViewController: vc)
        controller.tabBarItem.title = itemName
        controller.tabBarItem.image = UIImage(systemName: itemImage)
        controller.navigationItem.title = itemName
        controller.navigationBar.scrollEdgeAppearance = controller.navigationBar.standardAppearance
        return controller
    }
    
   
    
}
