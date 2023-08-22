//
//  ViewModelTests.swift
//  ViewModelTests
//
//  Created by Новгородцев Никита on 21.08.2023.
//

import XCTest
@testable import Resume

final class ViewModelTests: XCTestCase {
    
    var viewModel: MainViewModelProtocol!

    override func setUpWithError() throws {
        viewModel = MainViewModel()
    }

    override func tearDownWithError() throws {
       viewModel = nil
    }

    func testDeleteItem() throws {
        viewModel.skills = ["0", "1"]
        viewModel.deleteItem(index: 0)
        
        XCTAssert(viewModel.skills.first == "1")
        XCTAssert(viewModel.skills.count == 1)
    }

    func testAppendItem() throws {
        viewModel.skills = []
        viewModel.appendItem(title: "0")
        
        XCTAssert(viewModel.skills.first == "0")
    }

}
