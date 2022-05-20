//
//  LiveScoreSearchManager.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/19.
//

import Foundation
import Alamofire

protocol LiveScoreSearchManagerProtocol {
    func request(completionHandler: @escaping ([Result]) -> Void)
}

struct LiveScoreSearchManager: LiveScoreSearchManagerProtocol {
    func request(completionHandler: @escaping ([Result]) -> Void) {
        guard let url = URL(string: "https://api.football-data.org/v2/matches/") else { return }
        
        let headers: HTTPHeaders = [
            "X-Auth-Token": "89985cdcf8434ca99272d4e3faf4309c"
        ]
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: ResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.matches)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}
