//
//  MainViewControllerTests.swift
//  InterviewTests
//
//  Created by Natali Cabral on 26/08/24.
//

import XCTest
@testable import Interview

class MainViewControllerTests: XCTestCase {

    var sut: MainViewController!
    var mockViewModel: MockMainViewModel!

    override func setUp() {
        super.setUp()
        mockViewModel = MockMainViewModel()
        sut = MainViewController(viewModel: mockViewModel)
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        mockViewModel = nil
        super.tearDown()
    }

    func testShowLoading() {
        sut.showLoading()
        XCTAssertTrue(sut.loadingView.isAnimating)
        XCTAssertTrue(sut.mainTableView.isHidden)
        XCTAssertTrue(sut.errorView.isHidden)
    }

    func testHideLoading() {
        sut.hideLoading()
        XCTAssertFalse(sut.loadingView.isAnimating)
        XCTAssertFalse(sut.mainTableView.isHidden)
    }

    func testShowError() {
        sut.showError()
        XCTAssertFalse(sut.errorView.isHidden)
        XCTAssertFalse(sut.mainTableView.isHidden)
    }

    func testHideError() {
        sut.hideError()
        XCTAssertTrue(sut.errorView.isHidden)
    }

    func testReloadData() {
        sut.reloadData()
        XCTAssertFalse(sut.loadingView.isAnimating)
        XCTAssertTrue(sut.errorView.isHidden)
    }
    
    func testNumberOfRowsInSection() {
        mockViewModel.mockPokemonCount = 10
        XCTAssertEqual(sut.tableView(sut.mainTableView.tableView, numberOfRowsInSection: 0), 10)
    }

    func testCellForRowAt() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(sut.mainTableView.tableView, cellForRowAt: indexPath) as? MainViewCell
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.nameLabel.text, "1 - Pikachu")
    }

    func testActivitySectionGreaterThanZero() {
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView(sut.mainTableView.tableView, didSelectRowAt: indexPath)
        XCTAssertGreaterThan(sut.mainTableView.tableView.numberOfSections, 0)
    }

    class MockMainViewModel: MainViewModelDelegate {
        
        
        var viewControllerDelegate: MainViewControllerDelegate?
        var mockPokemonCount: Int = 0
        var didSelectPokemonCalled = false

        func getPokemonData() {}
        func countOfPokemons() -> Int { return mockPokemonCount }
        func getPokemon(for index: Int) -> Interview.PokemonRowModel { return Interview.PokemonRowModel(pokemonName: "Pikachu", backGround: .black , textColor: .black , url: "https://pokeapi.co/api/v2/pokemon/1/") }
    }

}
