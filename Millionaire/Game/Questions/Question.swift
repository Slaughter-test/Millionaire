//
//  Question.swift
//  Millionaire
//
//  Created by Юрий Егоров on 07.04.2021.
//

import Foundation

struct Question: Codable {
    var quest: String
    var answers: [Answer]
}

struct Answer: Codable {
    var text: String
    var isCorrect: Bool
}


class QuestionBuiler {
    
    private(set) var questions: [Question] = []
    private(set) var answers: [Answer] = []
    private(set) var singleQuestion: Question = Question(quest: "", answers: [])
    private(set) var textForQuestion: String = ""
    
    func build() -> [Question] {
        return questions
    }
    
    func addQuestion() -> QuestionBuiler {
        self.singleQuestion = Question(quest: textForQuestion, answers: answers)
        self.questions.append(singleQuestion)
        self.answers = []
        self.textForQuestion = ""
        self.singleQuestion = Question(quest: "", answers: [])
        return self
        
    }
    
    func addTextForQuestion(_ text: String) -> QuestionBuiler {
        self.textForQuestion = text
        return self
    }
    
    func addAnswer(_ text: String, _ isRight: Bool) -> QuestionBuiler {
        self.answers.append(Answer(text: text, isCorrect: isRight))
        return self
    }
    
    func sortAnswers() -> QuestionBuiler {
        var sortedAnswers: [Answer] = []
        var answersForSorting = answers
        for _ in 1...answersForSorting.count {
            let randomNumber = Int.random(in: 0...answersForSorting.count - 1)
            let randomAnswer = answersForSorting[randomNumber]
            answersForSorting.remove(at: randomNumber)
            sortedAnswers.append(randomAnswer)
            answers = sortedAnswers
        }
        return self
    }
    
}
