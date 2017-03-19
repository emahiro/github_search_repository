//
//  JSONDecodable.swift
//  github_search_repository
//
//  Created by Hiromichi Ema on 2017/03/19.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation

protocol JSONDecodable {
    init (json: Any) throws
}
