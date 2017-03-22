//
//  SearchResponse.swift
//  github_search_repository
//
//  Created by Hiromichi Ema on 2017/03/19.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation

struct SearchResponse<Item: JSONDecodable>: JSONDecodable {
    
    let totalCount: Int
    let items: [Item]
    
    init(json: Any) throws {
        
        guard let dictionary = json as? [String: Any] else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        guard let totalCount = dictionary["total_count"] as? Int else {
            throw JSONDecodeError.missingValue(key: "total_count", actualValue: dictionary["total_count"])
        }
        
        guard let itemsObj = dictionary["items"] as? [Any] else {
            throw JSONDecodeError.missingValue(key: "items", actualValue: dictionary["items"])
        }
        
        
        self.totalCount = totalCount
        self.items = try itemsObj.map {
            return try Item(json: $0)
        }
    }
}
