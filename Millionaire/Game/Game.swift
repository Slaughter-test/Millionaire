//
//  Game.swift
//  Millionaire
//
//  Created by Юрий Егоров on 04.04.2021.
//

import Foundation

struct Record: Codable {
    let score: Double
    let date: Date
}

class Game {
    
    static let shared = Game()
    
    private(set) var records: [Record] = []
    
    var gameSession: GameSession?
    
    
    func addRecord() {
        guard let questions = gameSession?.questions,
        let answeredQuestions = gameSession?.rightAnsweredQuestions else { return }
        var score: Double = 0.0
        if answeredQuestions != 0 {
            score = Double(answeredQuestions) / Double(questions) * 100
        } else {
            score = 0
        }
        let record = Record(score: score, date: Date())
        self.records.append(record)
        self.recordsCareTaker.save(self.records)
        self.gameSession = nil
    }
    
    func clearAllRecords() {
        self.records = []
    }
    
    
    let recordsCareTaker = RecordsCareTaker()
    
    private init() {
        self.records = recordsCareTaker.retriveRecords()
    }
}

