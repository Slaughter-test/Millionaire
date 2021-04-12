//
//  GameSession.swift
//  Millionaire
//
//  Created by Юрий Егоров on 08.04.2021.
//

import Foundation


class GameSession: GameViewControllerDelegate {
    
    @Observable var questions: Int = 0
    @Observable var answers: Int = 0
    var date: Date = Date()
    
    func gameViewController(questions: Int, answers: Int, date: Date) {
        self.questions = questions
        self.answers = answers
        self.date = date
    }
    
    
}
