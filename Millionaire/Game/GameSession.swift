//
//  GameSession.swift
//  Millionaire
//
//  Created by Юрий Егоров on 04.04.2021.
//

import Foundation
import UIKit


class GameSession: GameViewControllerDelegate {
    func gameViewController(_ controller: GameViewController, didEndWithResult result: Int, questions: Int, rightAnsweredQuestions: Int, date: Date) {
        self.result = result
        self.questions = questions
        self.rightAnsweredQuestions = rightAnsweredQuestions
        self.date = date
        Game.shared.addRecord()
        controller.dismiss(animated: true, completion: nil)
    }
    
     var result: Int = 0
     var questions: Int = 0
     var rightAnsweredQuestions: Int = 0
     var date: Date = Date()

    
}
