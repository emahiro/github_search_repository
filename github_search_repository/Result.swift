//
//  Result.swift
//  github_search_repository
//
//  Created by Hiromichi Ema on 2017/03/19.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation

enum Result<T, Error: Swift.Error> {
    case success(T)
    case failure(Error)
    
    init(value: T) {
        self = .success(value)
    }
    
    init(error: Error) {
        self = .failure(error)
    }
}
