//
//  Array+Extension.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation

extension Array {
    func object(index: Int) -> Element? {
        guard index >= 0 else { return nil }
        guard index < count else { return nil }
        return self[index]
    }
}
