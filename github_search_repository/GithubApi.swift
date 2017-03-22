//
//  GithubApi.swift
//  github_search_repository
//
//  Created by Hiromichi Ema on 2017/03/19.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation

final class GithubApi {
    
    struct SearchReposities: GithubRequest {
        
        let keyword: String
        
        // GithubAPIが要求する連想型
        typealias Response = SearchResponse<Repository>
        
        var path: String {
            return "/search/repositories"
        }
        
        var parameters: Any? {
            return ["q": keyword]
        }
    }
    
    struct SearchUsers: GithubRequest {
        
        let keyword: String
        typealias Response = SearchResponse<User>
        
        var path: String {
            return "search/users"
        }
        
        var parameters: Any? {
            return ["q": keyword]
        }
    }
}
