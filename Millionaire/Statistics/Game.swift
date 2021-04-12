//
//  Game.swift
//  Millionaire
//
//  Created by Юрий Егоров on 08.04.2021.
//

import Foundation

struct Result: Codable {
    var winPercent: Double
    var date: Date
}

final class Game {
    
    static let shared = Game()
    
    let resultCareTaker = GameCareTaker()
    
    let questionCareTaker = QuestionCareTaker()
    
    private(set) var results: [Result] = []
    
    private(set) var questions: [Question] = []
    
    var gameSession: GameSession?
    
    var questionQueue: QuestionQueue?
    
    private init() {
        self.results = resultCareTaker.load()
        self.questions = questionCareTaker.load()
    }
    
    private func calculateWinPercent() -> Double {
        guard let session = gameSession else { return 0.0 }
        return (Double(session.answers) / Double(session.questions) * 100)
        
    }
    
    func addResult() {
        guard let session = gameSession else { return }
        let result = Result(winPercent: calculateWinPercent(), date: session.date)
        self.results.append(result)
        self.resultCareTaker.save(self.results)
        self.gameSession = nil
    }
    
    func addQuestion(_ questions: [Question]) {
        self.questions.append(contentsOf: questions)
        self.questionCareTaker.save(self.questions)
    }
    
    func clearRecords() {
        self.results = []
    }
    
    
}
