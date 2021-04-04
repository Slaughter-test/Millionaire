//
//  GameViewController.swift
//  Millionaire
//
//  Created by Юрий Егоров on 04.04.2021.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {    
    func gameViewController(_ controller: GameViewController, didEndWithResult result: Int, questions: Int, rightAnsweredQuestions: Int, date: Date)
}

final class GameViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    
    @IBAction func dismiss(_ sender: UIButton) {
        endGame()
        self.dismiss(animated: true, completion: nil)
    }
    
    var delegate = GameSession()
    
    var onEndGame: ((Int, Int, Int, Date) -> Void)?
    
    //список вопросов
    var questions: [Question] = {
        let answers1 = [Answer(text: "Милан", isCorrect: false), Answer(text: "Вена", isCorrect: false), Answer(text: "Париж", isCorrect: false), Answer(text: "Берлин", isCorrect: true)]
        let question1 = Question(quest: "В каком городе не работал великий композитор 18-го века Кристоф Виллибальд Глюк?", answers: answers1)
        let answers2 = [Answer(text: "Венгрия", isCorrect: true), Answer(text: "Германия", isCorrect: false), Answer(text: "Польша", isCorrect: false), Answer(text: "Австрия", isCorrect: false)]
        let question2 = Question(quest: "С какой из этих стран Чехия не граничит?", answers: answers2)
        let answers3 = [Answer(text: "Курильская", isCorrect: false), Answer(text: "Корейская", isCorrect: false), Answer(text: "Карельская", isCorrect: true), Answer(text: "Канадская", isCorrect: false)]
        let question3 = Question(quest: "Какой вид березы славится красивой древесиной?", answers: answers3)
        let answers4 = [Answer(text: "Иудаизм", isCorrect: false), Answer(text: "Индуизм", isCorrect: false), Answer(text: "Буддизм", isCorrect: true), Answer(text: "Даосизм", isCorrect: false)]
        let question4 = Question(quest: "Одним из направлений какой религиозной философии является учение дзен?", answers: answers4)
        let answers5 = [Answer(text: "Канн", isCorrect: false), Answer(text: "Венеция", isCorrect: true), Answer(text: "Берлин", isCorrect: false), Answer(text: "Париж", isCorrect: false)]
        let question5 = Question(quest: "В каком городе в 1932 году был проведён первый международный кинофестиваль? ", answers: answers5)
        return [question1, question2, question3, question4, question5]
    
    }()
    // каунт всех вопросов для передачи в результаты
    private var questionsCount = 0
    
    // текущий вопрос
    private var currentQuestion: Question?
    
    // массив верно отвеченных вопросов
    private var answeredQuestions: [Question] = []
    
    // кол-во заработанных денег
    private var money: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Game.shared.gameSession = delegate
        
        onEndGame = { [weak self] result, questions, rightAnsweredQuestions, date in
            guard let self = self else { return }
            
            self.delegate.gameViewController(self,
                                              didEndWithResult: result,
                                              questions: questions,
                                              rightAnsweredQuestions: rightAnsweredQuestions,
                                              date: date)
        }
        setupPressButtons()
        questionsCount = questions.count
        scoreLabel.text = "\(money)"
        getQuestion()
    }
    
    
    //MARK: - Конфигурация текущего вопроса
    
    private func getQuestion() {
        setCurrentQuestion()
        questionLabel.text = currentQuestion?.quest
        buttonA.setTitle(currentQuestion?.answers[0].text, for: .normal)
        buttonB.setTitle(currentQuestion?.answers[1].text, for: .normal)
        buttonC.setTitle(currentQuestion?.answers[2].text, for: .normal)
        buttonD.setTitle(currentQuestion?.answers[3].text, for: .normal)
        scoreLabel.text = String(money)
    }
    
    //MARK: -  установка текущего вопроса
    private func setCurrentQuestion() {
        if questions.count != 0 {
            currentQuestion = questions[0]
            questions.remove(at: 0)
        } else {
            endGame()
        }
    }
    
    //MARK: - проверка правильного ответа
    @objc
    func checkAnswer(_ sender: UIButton) {
        let rightAnswer = returnRightAnswer(question: currentQuestion!)
        if sender.titleLabel?.text == rightAnswer {
            answeredQuestions.append(currentQuestion!)
            money = money + 10000
            getQuestion()
        } else {
            endGame()
        }

    }
    //MARK: - конец игры
    private func endGame() {
        let result = money
        let count = questionsCount
        let answeredCount = answeredQuestions.count
        let date = Date()
        self.onEndGame?(result, count, answeredCount, date)
    }
    //MARK: - вернуть корректный ответ из текущего вопроса
    private func returnRightAnswer(question: Question) -> String {
        var rightAnswer = ""
        for answer in question.answers {
            if answer.isCorrect == true {
                rightAnswer = answer.text
        }
        }
        return rightAnswer
    }
    //MARK: - добавление таргетов на все кнопки для проверки ответа
    private func setupPressButtons() {
        buttonA.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        buttonB.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        buttonC.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        buttonD.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
    }
}

