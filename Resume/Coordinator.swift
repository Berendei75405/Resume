//
//  Coordinator.swift
//  Resume
//
//  Created by user on 01.08.2023.
//

import UIKit

protocol MainCoordinatorProtocol: AnyObject {
    func createMainModule() -> UIViewController
    func initailViewController()
}

final class MainCoordinator: MainCoordinatorProtocol {
    var navigationController: UINavigationController?
    
    //MARK: - init
    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    //MARK: - createMainModule
    func createMainModule() -> UIViewController {
        let view = MainViewController()
        let viewModel = MainViewModel()
        let coordinator = self
        
        view.viewModel = viewModel
        viewModel.coordinator = coordinator
        
        return view
    }
    
    //MARK: - initialViewController
    func initailViewController() {
        if let navCon = navigationController {
            let view = createMainModule()
            
            navCon.navigationBar.setBackgroundImage(UIImage(named: "gray"), for: .default)
            navCon.navigationBar.isTranslucent = true
            navCon.viewControllers = [view]
        }
    }
    
}
