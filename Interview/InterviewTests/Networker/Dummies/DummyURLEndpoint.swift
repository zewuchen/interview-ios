//
//  DummyURLEndpoint.swift
//  InterviewTests
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation
@testable import Interview

struct DummyURLEndpoint: URLEndpoint {
    var host: String = ""
    var baseUrl: String = ""
    var url: URL = URL(string: "www.dummy.com")!
    var method: HTTPMethod = .GET
}
