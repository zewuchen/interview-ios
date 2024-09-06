//
//  MathHelper.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
import UIKit

protocol MathHelperProtocool {
    func isIndexEven(_ index: Int) -> Bool
    func isIndexMultipleOf(_ index: Int, multiple: Int) -> Bool
}

final class MathHelper: MathHelperProtocool {
    func isIndexEven(_ index: Int) -> Bool {
        return index % 2 == 0
    }
    
    func isIndexMultipleOf(_ index: Int, multiple: Int) -> Bool {
        return index % multiple == 0
    }
}
