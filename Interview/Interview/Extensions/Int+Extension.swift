//
//  Int+Extension.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation

extension Optional where Wrapped == Int {
    func toString() -> String? {
        guard let self else { return nil }
        return String(self)
    }
}
