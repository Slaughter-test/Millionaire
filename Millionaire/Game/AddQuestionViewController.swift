//
//  AddQuestionViewController.swift
//  Millionaire
//
//  Created by Юрий Егоров on 11.04.2021.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var answerAField: UITextField!
    @IBOutlet weak var answerBField: UITextField!
    @IBOutlet weak var answerCField: UITextField!
    @IBOutlet weak var answerDField: UITextField!
    @IBAction func addQuestion(_ sender: UIButton) {
        guard let questionText = questionField.text,
              let answerAtext = answerAField.text,
              let answerBtext = answerBField.text,
              let answerCtext = answerCField.text,
              let answerDtext = answerDField.text
        else { return }
        
        let builder = QuestionBuiler()
        let questions = builder.addTextForQuestion(questionText).addAnswer(answerAtext, false).addAnswer(answerBtext, false).addAnswer(answerCtext, false).addAnswer(answerDtext, true).sortAnswers().addQuestion().build()
        Game.shared.addQuestion(questions)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
