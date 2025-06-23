//
//  MathHelperSpy.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
import UIKit
@testable import Interview

final class MathHelperSpy: MathHelperProtocool {
    private(set) var isNumberEvenVerifier: [Int] = []
    private(set) var isNumberMultipleOfVerifier: [(number: Int, multiple: Int)] = []
    
    var isNumberEvenToBeReturned: Bool = false
    var isNumberMultipleOfToBeReturned: Bool = false
    
    func isNumberEven(_ number: Int) -> Bool {
        isNumberEvenVerifier.append(number)
        return isNumberEvenToBeReturned
    }
    
    func isNumberMultipleOf(_ number: Int, multiple: Int) -> Bool {
        isNumberMultipleOfVerifier.append((number, multiple))
        return isNumberMultipleOfToBeReturned
    }
}
