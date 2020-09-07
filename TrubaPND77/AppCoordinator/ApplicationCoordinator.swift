//
//  ApplicationCoordinator.swift
//  TrubaPND77
//
//  Created by Serg on 18.08.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator {
    
    fileprivate func createTabBarController() -> UIViewController? {
        let mainCoordinator: MainScreenRouterInput? = DependenceProvider.resolve()
        
        guard let mainTabController = (mainCoordinator as? BasicRoutingCoordinatorProtocol)?.start() else {
            objectDescription(self, function: #function)
            return nil
        }
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .yellow
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .red
        
        let vc4 = UIViewController()
        vc4.view.backgroundColor = .green
        
        let array = [
            createNavController(viewController: mainTabController, title: "Главная", imageName: "house", nav: true),
            createNavController(viewController: vc2, title: "Каталог", imageName: "catalog", nav: true),
            createNavController(viewController: vc3, title: "О компании", imageName: "info.circle", nav: true),
            createNavController(viewController: vc4, title: "Контакты", imageName: "location", nav: true)
            
        ]
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = array
        
        if tabBarController.traitCollection.horizontalSizeClass == .regular {
            let systemFontAttributesForIPad = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
            UITabBarItem.appearance().setTitleTextAttributes(systemFontAttributesForIPad, for: .normal)
        }
        
        return tabBarController
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String, nav: Bool) -> UIViewController {
        
        let image = UIImage(named: imageName)
        let selectedImage = UIImage(named: imageName + ".fill")
        viewController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        viewController.navigationItem.title = title
        
        
        let navigationController = nav ? UINavigationController(rootViewController: viewController) : viewController
        return navigationController
    }
}

extension ApplicationCoordinator: ApplicationCoordinatorProtocol {
    func prepareWindow() -> UIWindow {
        let window = UIWindow()
        window.rootViewController = self.createTabBarController()
        window.makeKeyAndVisible()
        return window
    }
    
    @available(iOS 13.0, *)
    func prepareWindow(with scene: UIWindowScene) -> UIWindow {
        let window = UIWindow(windowScene: scene)
        window.rootViewController = self.createTabBarController()
        window.makeKeyAndVisible()
        return window
    }
}
