//
//  ViewController.swift
//  Millionaire
//
//  Created by Юрий Егоров on 04.04.2021.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    
    @IBOutlet private weak var resultsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "startGameSegue" else { return }
    }
    
}

