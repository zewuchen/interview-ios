//
//  EnvironmentStub.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
@testable import Interview

struct EnvironmentStub: EnvironmentProtocol {
    let host: String
    
    init(host: String = "dummy_host") {
        self.host = host
    }
}
