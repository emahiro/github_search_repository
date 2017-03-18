//
//  User.swift
//  github_search_repository
//
//  Created by Hiromichi Ema on 2017/03/18.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation

struct User {
    let id: Int
    let login: String
    
    init(json: Any) throws{
        guard let dictinary = json as? [String: Any] else{
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        guard let id = dictinary["id"] as? Int else {
            throw JSONDecodeError.missongValue(key: "id", actualValue: dictinary["id"])
        }
        
        guard let login = dictinary["login"] as? String else {
            throw JSONDecodeError.missongValue(key: "login", actualValue: dictinary["login"])
        }
        
        self.id = id
        self.login = login
        
    }
}
