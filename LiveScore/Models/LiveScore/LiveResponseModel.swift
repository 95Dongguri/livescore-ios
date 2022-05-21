//
//  LiveResponseModel.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/19.
//

import Foundation

struct LiveResponseModel: Decodable {
    var matches: [Result] = []
}

struct Result: Decodable {
    let status: String
//    var utcDate: String    경기시작시간
    var competition: Competition
    var score: Score
    let homeTeam: HomeTeam
    let awayTeam: AwayTeam
}

struct Competition: Decodable {
    let emblem: String?
}

struct Score: Decodable {
    var fullTime: FullTime?
}

struct FullTime: Decodable {
    var home: Int?
    var away: Int?
}

struct HomeTeam: Decodable {
    let name: String
//    let crest: String? // 팀 로고
}

struct AwayTeam: Decodable {
    let name: String
//    let crest: String? // 팀 로고
}
