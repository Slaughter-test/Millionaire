//
//  RecordsTableViewController.swift
//  Millionaire
//
//  Created by Юрий Егоров on 04.04.2021.
//

import UIKit

class RecordsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBAction func onClosePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.shared.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record = Game.shared.records[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = "Результат: \(Int(record.score)) %"
        cell.detailTextLabel?.text = DateFormatter.localizedString(from: record.date, dateStyle: .medium, timeStyle: .medium)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
}

