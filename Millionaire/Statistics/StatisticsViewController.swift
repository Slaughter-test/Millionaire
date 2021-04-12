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
        return Game.shared.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = StatistictTableView.dequeueReusableCell( withIdentifier: "statisticsCell", for: indexPath)
        let record = Game.shared.results[indexPath.row]
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "statisticsCell")
        cell.textLabel?.text = "Результат: \(Int(record.winPercent)) %"
        cell.detailTextLabel?.text = DateFormatter.localizedString(from: record.date, dateStyle: .medium, timeStyle: .medium)
        cell.backgroundColor = .black
        cell.textLabel?.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)
        cell.detailTextLabel?.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 1)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StatistictTableView.delegate = self
        self.StatistictTableView.dataSource = self
        configureTableView()
    }
    
    private func configureTableView() {
        // конфиг для черной таблички
        self.StatistictTableView.separatorStyle = .singleLine
        self.StatistictTableView.separatorColor = .white
        self.StatistictTableView.backgroundColor = .black
        // чтобы не было лишних сепараторов
        self.StatistictTableView.tableFooterView = UIView()
    }
    
}
