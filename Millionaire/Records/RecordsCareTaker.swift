//
//  RecordsCareTaker.swift
//  Millionaire
//
//  Created by Юрий Егоров on 04.04.2021.
//

import Foundation


import Foundation

class RecordsCareTaker {
    
    static let recordsKey = "records"
    
    func save(_ records: [Record]) {
        guard let data = try? JSONEncoder().encode(records) else { return }
        UserDefaults.standard.set(data, forKey: Self.recordsKey)
    }
    
    func retriveRecords() -> [Record] {
        guard let data = UserDefaults.standard.value(forKey: Self.recordsKey) as? Data else { return [] }
        return (try? JSONDecoder().decode([Record].self, from: data)) ?? []
    }
}
