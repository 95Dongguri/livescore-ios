//
//  ScoreResponseModel.swift
//  LiveScore
//
//  Created by 김동혁 on 2022/05/21.
//

import Foundation

struct ScoreResponseModel: Decodable {
    var scorers: [Scorers] = []
}

struct Scorers: Decodable {
    let player: Player
    let team: Team
    let goals: Int?
    let assists: Int?
    let penalties: Int?
}

struct Player: Decodable {
    let name: String
    let dateOfBirth: String
    let nationality: String
    let position: String
}

struct Team: Decodable {
    let name: String
    let crest: String?
}
