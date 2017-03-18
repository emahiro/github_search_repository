//
//  JSONDecodeError.swift
//  github_search_repository
//
//  Created by Hiromichi Ema on 2017/03/18.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation

enum JSONDecodeError: Error {
    case invalidFormat(json: Any)
    case missongValue(key: String, actualValue: Any?)
}
