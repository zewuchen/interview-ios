//
//  DummyEndpoint.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
@testable import Interview

struct DummyEndpoint: Endpoint {
    var host: String = "dummy_host"
    var baseUrl: String = "/dummy_baseUrl"
    var method: HTTPMethod = .GET
}
