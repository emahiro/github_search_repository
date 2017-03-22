//
//  GithubRequest.swift
//  github_search_repository
//
//  Created by Hiromichi Ema on 2017/03/19.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation

protocol GithubRequest {
    
    associatedtype Response: JSONDecodable
    
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HttpMethod { get }
    var parameters: Any?  { get } //[String: String] で表現できる
}

extension GithubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var httpMethod: HttpMethod {
        return .get
    }
    
    func buildUrlRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        switch httpMethod {
        case .get:
            let dictionary = parameters as? [String: Any]
            let queryItem = dictionary?.map { key, value in
                URLQueryItem(name: key, value: String(describing: value))
            }
            
            components?.queryItems = queryItem
            
        default:
            fatalError("Unsupported method: \(httpMethod)")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = httpMethod.rawValue
        
        return urlRequest
    }
    
    func response (data: Data, urlResponse: URLResponse) throws -> Response {
        
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        
        if case (200..<300)? = (urlResponse as? HTTPURLResponse)?.statusCode {
            return try Response(json: json)
        } else {
            // GithubApiError も JSONDecodable に準拠しているので同様に JSONDecodable型に準拠しているResponse型として扱える
            throw try GithubApiError(json: json)
        }
    }
}
