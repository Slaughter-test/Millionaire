//
//  StatisticsViewController.swift
//  Millionaire
//
//  Created by Юрий Егоров on 07.04.2021.
//

import UIKit

class StatisticsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var StatistictTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.shared.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = StatistictTableView.dequeueReusableCell( withIdentifier: "statisticsCell", for: indexPath)
        let record = Game.shared.records[indexPath.row]
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "statisticsCell")
        cell.textLabel?.text = "Результат: \(Int(record.score)) %"
        cell.detailTextLabel?.text = DateFormatter.localizedString(from: record.date, dateStyle: .medium, timeStyle: .medium)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StatistictTableView.delegate = self
        self.StatistictTableView.dataSource = self
    }
    
}
