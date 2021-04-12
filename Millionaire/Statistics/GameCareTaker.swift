//
//  GameCareTaker.swift
//  Millionaire
//
//  Created by Юрий Егоров on 07.04.2021.
//

import Foundation

final class GameCareTaker {
    
    static let key = "records"
    
    func save(_ records: [Result]) {
        guard let data = try? JSONEncoder().encode(records) else { return }
        UserDefaults.standard.set(data, forKey: Self.key)
    }
    
    func load() -> [Result] {
        guard let data = UserDefaults.standard.value(forKey: Self.key) as? Data else { return [] }
        return (try? JSONDecoder().decode([Result].self, from: data)) ?? []
    }
    
}
