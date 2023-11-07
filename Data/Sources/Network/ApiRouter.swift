//
//  File.swift
//
//
//  Created by atakishiyev on 11/4/23.
//

import Foundation

public enum ApiRouter {
    public typealias Params = [String: Any]
    
    case mealList(params: Params)
    case mealDetail(params: Params)
    case imageUrl(imageUrl: String)
    
    func asURLRequest() -> URLRequest {
        let httpMethod = getHttpMethod()
        let url = createURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.timeoutInterval = 20.0
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        return urlRequest
    }
    
    func queryItems() -> [URLQueryItem] {
        guard getHttpMethod() == .get, let parameters = getParams() else {
            return []
        }
        return parameters.map { (key: String, value: Any?) -> URLQueryItem in
            let valueString = String(describing: value!)
            return URLQueryItem(name: key, value: valueString)
        }
    }
    
    func getHttpMethod() -> HTTPMethod {
        switch self {
        case .mealList, .mealDetail, .imageUrl:
            return .get
        }
    }
    
    func getParams() -> Params? {
        switch self {
        case .mealList(let params), .mealDetail(let params):
            return params
        default: return nil
        }
    }
    
    var urlPath: String {
        switch self {
        case .mealList:
            return "/filter.php"
        case .mealDetail:
            return "/lookup.php"
        case .imageUrl(let imageUrl):
            return imageUrl
        }
    }
    
    func createURL() -> URL {
        switch self {
        case .imageUrl(let imageUrl):
            return URL(string: imageUrl)!
        default:
            var components = URLComponents()
            components.scheme = "https"
            components.host = "themealdb.com"
            components.path = "/api/json/v1/1\(urlPath)"
            components.queryItems = queryItems()
            return components.url!
        }
    }
}

extension ApiRouter {
    enum HTTPMethod: String {
        case get = "GET"
    }
}

