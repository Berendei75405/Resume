//
//  CoordinatorTests.swift
//  ResumeTests
//
//  Created by Новгородцев Никита on 22.08.2023.
//

import XCTest
@testable import Resume

final class CoordinatorTests: XCTestCase {
    
    var coordinator: MainCoordinatorProtocol!
    var navController = UINavigationController()

    override func setUpWithError() throws {
        coordinator = MainCoordinator(navController: navController)
    }

    override func tearDownWithError() throws {
        coordinator = nil
    }

    func testInitailViewController() throws {
        coordinator.initailViewController()
        let mockView = navController.viewControllers.first
        
        XCTAssertTrue(mockView != nil)
    }
    
    func testCreateMainModule() throws {
        let mockView = coordinator.createMainModule()
 
        XCTAssert(mockView is MainViewController)
    }

}
