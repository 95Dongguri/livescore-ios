//
//  LiveScoreSearchManager.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/19.
//

import Foundation
import Alamofire

protocol LiveScoreSearchManagerProtocol {
    func request(from dateFrom: String, completionHandler: @escaping ([Result]) -> Void)
}

struct LiveScoreSearchManager: LiveScoreSearchManagerProtocol {
    func request(from date: String, completionHandler: @escaping ([Result]) -> Void) {
        guard let url = URL(string: "https://api.football-data.org/v4/matches") else { return }
        
        let parameters = LiveRequestModel(date: date)
        let headers: HTTPHeaders = [
            "X-Auth-Token": "89985cdcf8434ca99272d4e3faf4309c"
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: LiveResponseModel.self) { response in
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
