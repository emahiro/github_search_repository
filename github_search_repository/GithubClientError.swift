//
//  GithubClientError.swift
//  github_search_repository
//
//  Created by Hiromichi Ema on 2017/03/19.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation

enum GithubClientError: Error {
    // 通信の失敗
    case connectionError(Error)
    // レスポンスの解釈に失敗
    case responseParseError(Error)
    // apiからのエラーレスポンス
    case githubApiError(GithubApiError)
}
