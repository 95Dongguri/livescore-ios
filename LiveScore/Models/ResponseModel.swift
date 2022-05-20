//
//  ResponseModel.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/19.
//

import Foundation

struct ResponseModel: Decodable {
    var matches: [Result] = []
}

struct Result: Decodable {
    var competition: Competition
    var score: Score
    let homeTeam: HomeTeam
    let awayTeam: AwayTeam
}

struct Competition: Decodable {
    let area: Area?
}

struct Area: Decodable {
    var ensignUrl: String?
}

struct Score: Decodable {
    var fullTime: FullTime?
}

struct FullTime: Decodable {
    var homeTeam: Int?
    var awayTeam: Int?
}

struct HomeTeam: Decodable {
    let name: String
}

struct AwayTeam: Decodable {
    let name: String
}
