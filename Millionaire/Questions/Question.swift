//
//  Question.swift
//  Millionaire
//
//  Created by Юрий Егоров on 04.04.2021.
//

import Foundation


struct Question {
    var quest: String
    var answers: [Answer]
    
    init( quest: String,
          answers: [Answer]) {
        self.quest = quest
        self.answers = answers
    }
}
struct Answer {
    var text: String
    var isCorrect: Bool
    
    init( text: String,
          isCorrect: Bool) {
        self.text = text
        self.isCorrect = isCorrect
    }
}
