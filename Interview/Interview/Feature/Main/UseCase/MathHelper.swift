//
//  MathHelper.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
import UIKit

protocol MathHelperProtocool {
    func isNumberEven(_ number: Int) -> Bool
    func isNumberMultipleOf(_ number: Int, multiple: Int) -> Bool
}

final class MathHelper: MathHelperProtocool {
    func isNumberEven(_ number: Int) -> Bool {
        return number % 2 == 0
    }
    
    func isNumberMultipleOf(_ number: Int, multiple: Int) -> Bool {
        return number % multiple == 0
    }
}
