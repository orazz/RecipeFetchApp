//
//  Api.swift
//
//
//  Created by atakishiyev on 11/4/23.
//

import Foundation
import Common

public protocol Api {

    func callApi<T: Decodable>(route: ApiRouter, decodeType type: T.Type) async throws -> T
    func fetchImageData(route: ApiRouter) async throws -> Data
}
