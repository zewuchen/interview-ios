//
//  Logging.swift
//  Interview
//
//  Created by Rafael Ramos on 07/09/24.
//

import Foundation
import OSLog

final class Logging {
    private static let subsystem: String = Bundle.main.bundleIdentifier ?? ""
    
    static func debug(message: String, _class: Any) {
#if DEBUG
        Logger(subsystem: subsystem, category: String(describing: _class)).debug("DEBUG: ℹ️ \(message)")
#endif
    }
}
