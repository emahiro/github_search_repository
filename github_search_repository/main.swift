import Foundation

print("Please Enter Your Query Here > ", separator: "", terminator: "")

guard let keyword = readLine(strippingNewline: true) else {
    exit(1)
}

let client = GithubClient()
let request = GithubApi.SearchReposities(keyword: keyword)

// リクエストを送信
client.send(request: request) { result in
    
    switch result {
    case let .success(response):
        for item in response.items {
            // リポジトリの所有者と名前を出力
            print(item.owner.login + "/" + item.name)
            exit(0)
        }
    case let .failure(error):
        // エラーの発生と詳細を出力
        print("error occured: \(error)")
        exit(1)
    }
}

let timeOutInterval: TimeInterval = 10
Thread.sleep(forTimeInterval: timeOutInterval)

print("Connection timeout")
exit(1)

