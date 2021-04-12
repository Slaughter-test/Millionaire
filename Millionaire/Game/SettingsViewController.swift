//
//  SettingsViewController.swift
//  Millionaire
//
//  Created by Юрий Егоров on 09.04.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBAction func saveSettings(_ sender: UIButton) {
        switch self.segmentControl.selectedSegmentIndex {
        case 0:
            Game.shared.questionQueue = .direct
        case 1:
            Game.shared.questionQueue = .random
        case 2:
            Game.shared.questionQueue = .reverse
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch Game.shared.questionQueue {
        case .direct:
            self.segmentControl.selectedSegmentIndex = 0
        case .random:
            self.segmentControl.selectedSegmentIndex = 1
        case .reverse:
            self.segmentControl.selectedSegmentIndex = 2
        default:
            self.segmentControl.selectedSegmentIndex = 0
        }
    }
    
    
}
