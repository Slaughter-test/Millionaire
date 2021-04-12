//
//  GameViewController.swift
//  Millionaire
//
//  Created by Юрий Егоров on 07.04.2021.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {
    func gameViewController(questions: Int, answers: Int, date: Date)
}

final class GameViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionQueueLabel: UILabel!
    @IBOutlet weak var answerOne: UIButton!
    @IBOutlet weak var answerTwo: UIButton!
    @IBOutlet weak var answerThree: UIButton!
    @IBOutlet weak var answerFour: UIButton!
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        guard let question = currentQuestion else { return }
        if sender.titleLabel?.text == returnCorrectAnswer() {
            answeredQuestions.append(question)
            getQuestion()
        } else {
            endGame()
        }
        print("Проверка вопроса1")
    }
    
    private var questions: [Question] = []
    private var currentQuestion: Question?
    private var answeredQuestions: [Question] = []
    private var questionQueue = Game.shared.questionQueue
    private var sortQuestionStrategy: QuestionStrategy {
        switch self.questionQueue {
        case .random:
            return QuestionRandomStrategy()
        case .reverse:
            return QuestionReverseStrategy()
        case .none, .direct:
            return QuestionDirectStrategy()
        }
    }
    
    weak var delegate: GameViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Game.shared.gameSession = GameSession()
        delegate = Game.shared.gameSession
        createQuestions()
        questions = sortQuestionStrategy.sortQuestions(questions)
        getQuestion()
        Game.shared.gameSession?.$answers.addObserver(self, options: [.initial, .new], closure: {
            value, _ in
            self.questionQueueLabel.text = "\(value + 1) вопрос"
        })
    }
    
    private func createQuestions() {
        let builder = QuestionBuiler()
        questions = builder
            .addTextForQuestion("В каком городе не работал великий композитор 18-го века Кристоф Виллибальд Глюк?")
            .addAnswer("Милан", false)
            .addAnswer("Вена", false)
            .addAnswer("Берлин", true)
            .addAnswer("Париж", false)
            .addQuestion()
            .addTextForQuestion("С какой из этих стран Чехия не граничит?")
            .addAnswer("Венгрия", true)
            .addAnswer("Германия", false)
            .addAnswer("Польша", false)
            .addAnswer("Франция", false)
            .addQuestion()
            .addTextForQuestion("Какой вид березы славится красивой древесиной?")
            .addAnswer("Карельская", true)
            .addAnswer("Курильская", false)
            .addAnswer("Канадская", false)
            .addAnswer("Корейская", false)
            .addQuestion()
            .addTextForQuestion("Одним из направлений какой религиозной философии является учение дзен?")
            .addAnswer("Иудаизм", false)
            .addAnswer("Буддизм", true)
            .addAnswer("Даосизм", false)
            .addAnswer("Индуизм", false)
            .addQuestion()
            .addTextForQuestion("В каком городе в 1932 году был проведён первый международный кинофестиваль?")
            .addAnswer("Венеция", true)
            .addAnswer("Канн", false)
            .addAnswer("Берлин", false)
            .addAnswer("Париж", false)
            .addQuestion()
            .build()
        questions.append(contentsOf: Game.shared.questions)
    }
    
    private func returnCorrectAnswer() -> String {
        guard let question = currentQuestion else { return " " }
        var correctAnswer = " "
        for answer in question.answers {
            if answer.isCorrect == true {
                correctAnswer = answer.text
            }
        }
        return correctAnswer
    }
    
    private func getQuestion() {
        updateStatistics()
        if questions.count != 0 {
            currentQuestion = questions[0]
            questions.remove(at: 0)
            questionLabel.text = currentQuestion?.quest
            answerOne.setTitle(currentQuestion?.answers[0].text, for: .normal)
            answerTwo.setTitle(currentQuestion?.answers[1].text, for: .normal)
            answerThree.setTitle(currentQuestion?.answers[2].text, for: .normal)
            answerFour.setTitle(currentQuestion?.answers[3].text, for: .normal)
            
        } else {
            endGame()
        }
        
    }
    
    private func endGame() {
        updateStatistics()
        Game.shared.addResult()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func updateStatistics() {
        if questions.count != 0 {
            self.delegate?.gameViewController(questions: self.questions.count + self.answeredQuestions.count + 1, answers: self.answeredQuestions.count, date: Date())
        } else {
            self.delegate?.gameViewController(questions: self.questions.count + self.answeredQuestions.count , answers: self.answeredQuestions.count, date: Date())
        }
    }
    
}


