//
//  GithubClient.swift
//  github_search_repository
//
//  Created by Hiromichi Ema on 2017/03/19.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation

class GithubClient {
    
    private var session: URLSession {
        let configration = URLSessionConfiguration.default
        let session = URLSession(configuration: configration)
        return session
    }
    
    func send<Request: GithubRequest> (request: Request, completion: @escaping (Result<Request.Response, GithubClientError>) -> Void) {
        let urlRequest = request.buildUrlRequest()
        let urlSession = session.dataTask(with: urlRequest) { data, response, error in
            // 通信完了時の処理
        
            switch (data, response, error) {
            case (_, _, let error?):
                completion(Result(error: GithubClientError.connectionError(error)))
            
            case (let data?, let response?, _):
                
                do {
                    let response = try request.response(data: data, urlResponse: response)
                    completion(Result(value: response))
                } catch let error as GithubApiError {
                    completion(Result(error: GithubClientError.githubApiError(error)))
                } catch {
                    completion(Result(error: GithubClientError.responseParseError(error)))
                }
                
            default:
                fatalError("invalid response conbination!! data: \(data) response: \(response) error: \(error)")
            }
        }
    
        urlSession.resume() // session start
    }
}
