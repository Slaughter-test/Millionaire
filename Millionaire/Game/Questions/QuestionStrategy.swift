//
//  QuestionStrategy.swift
//  Millionaire
//
//  Created by Юрий Егоров on 09.04.2021.
//

import Foundation

protocol QuestionStrategy {
    func sortQuestions(_ questions: [Question]) -> [Question]
}

final class QuestionReverseStrategy: QuestionStrategy {
    
    func sortQuestions(_ questions: [Question]) -> [Question] {
        let sortedQuestions = Array(questions.reversed())
        return sortedQuestions
    }
    
}

final class QuestionRandomStrategy: QuestionStrategy {
    
    func sortQuestions(_ questions: [Question]) -> [Question] {
        var sortedQuestions: [Question] = []
        var questionForSorting = questions
        for _ in 1...questionForSorting.count {
            let randomNumber = Int.random(in: 0...questionForSorting.count - 1)
            let randomQuestion = questionForSorting[randomNumber]
            questionForSorting.remove(at: randomNumber)
            sortedQuestions.append(randomQuestion)
        }
        return sortedQuestions
    }
    
}

final class QuestionDirectStrategy: QuestionStrategy {
    
    func sortQuestions(_ questions: [Question]) -> [Question] {
        return questions
    }
    
}
