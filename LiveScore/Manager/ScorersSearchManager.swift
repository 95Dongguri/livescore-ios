//
//  ScorersSearchManager.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/21.
//

import Foundation
import Alamofire

protocol ScorersSearchManagerProtocol {
    func request(from league: String, completionHandler: @escaping ([Scorers]) -> Void)
}

struct ScorersSearchManager: ScorersSearchManagerProtocol {
    func request(from league: String, completionHandler: @escaping ([Scorers]) -> Void) {
        guard let url = URL(string: "https://api.football-data.org/v4/competitions/\(league)/scorers") else { return }
        
        let headers: HTTPHeaders = [
            "X-Auth-Token": "89985cdcf8434ca99272d4e3faf4309c"
        ]
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: ScoreResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.scorers)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
}

