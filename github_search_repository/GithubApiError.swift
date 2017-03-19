//
//  GithubApiError.swift
//  github_search_repository
//
//  Created by Hiromichi Ema on 2017/03/19.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation

struct GithubApiError: JSONDecodable, Error {
    
    struct FieldError: JSONDecodable{
        let resource: String
        let field: String
        let code: String
        
        init(json: Any) throws {
            guard let dictionary = json as? [String: Any] else {
                throw JSONDecodeError.invalidFormat(json: json)
            }
            
            guard let resource = dictionary["resource"] as? String else {
                throw JSONDecodeError.missingValue(key: "resource", actualValue: dictionary["resource"])
            }
            
            guard let field = dictionary["field"] as? String else {
                throw JSONDecodeError.missingValue(key: "field", actualValue: dictionary["field"])
            }
            
            guard let code = dictionary["code"] as? String else {
                throw JSONDecodeError.missingValue(key: "code", actualValue: dictionary["code"])
            }
            
            self.resource = resource
            self.field = field
            self.code = code
        }
    }
    
    let message: String
    let errors: [FieldError]
    
    init(json: Any) throws {
        guard let dictionary = json as? [String:Any] else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        guard let message = dictionary["message"] as? String else {
            throw JSONDecodeError.missingValue(key: "message", actualValue: dictionary["message"])
        }
        
        let fieldErrorsObj = dictionary["errors"] as? [Any] ?? []
        let errors = try fieldErrorsObj.map {
            return try FieldError(json: $0)
        }
        
        self.message = message
        self .errors = errors
    }
}
