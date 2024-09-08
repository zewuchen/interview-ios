//
//  InterviewUITests.swift
//  InterviewUITests
//
//  Created by Zewu Chen on 28/06/24.
//

import XCTest
@testable import Interview

final class InterviewUITests: XCTestCase {
    private let exists = NSPredicate(format: "exists == 1")
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {}
    
    func test_aplication_tapFirstTableViewCell_andShouldExpectedPokemonInformationLabels() throws {
        let app = XCUIApplication()
        app.launchArguments = ["UITests"]
        app.launch()
        
        let mainTableView = app.tables["tableview-main"]
        
        let firstTableCell = mainTableView.cells.firstMatch
        
        // wait for data loading and firstTableCell available
        let expectationFirstCell = expectation(for: exists, evaluatedWith: firstTableCell)
        wait(for: [expectationFirstCell], timeout: 3)
        
        XCTAssertTrue(firstTableCell.exists, "cell 0 is not on the table")
        
        expectationFirstCell.fulfill()
        
        firstTableCell.tap()
        
        let labelName = app.staticTexts["label-detail-name"]
        let labelNumber = app.staticTexts["label-detail-number"]
        let labelHeight = app.staticTexts["label-detail-height"]
        let labelWeight = app.staticTexts["label-detail-weight"]
        
        
        XCTAssertTrue(labelName.exists, "labelName is not on the controller")
        XCTAssertTrue(labelNumber.exists, "labelNumber is not on the controller")
        XCTAssertTrue(labelHeight.exists, "labelHeight is not on the controller")
        XCTAssertTrue(labelWeight.exists, "labelWeight is not on the controller")
        
        XCTAssertEqual(labelName.label, "Nome: Mock Pokemon Name 1")
        XCTAssertEqual(labelNumber.label, "Número: 123")
        XCTAssertEqual(labelHeight.label, "Altura: 70")
        XCTAssertEqual(labelWeight.label, "Peso: 55")
    }
}
