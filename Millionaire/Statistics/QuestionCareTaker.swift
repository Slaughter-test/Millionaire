//
//  QuestionCareTaker.swift
//  Millionaire
//
//  Created by Юрий Егоров on 11.04.2021.
//

import Foundation

final class QuestionCareTaker {
    
    static let key = "questions"
    
    func save(_ questions: [Question]) {
        guard let data = try? JSONEncoder().encode(questions) else { return }
        UserDefaults.standard.set(data, forKey: Self.key)
    }
    
    func load() -> [Question] {
        guard let data = UserDefaults.standard.value(forKey: Self.key) as? Data else { return [] }
        return (try? JSONDecoder().decode([Question].self, from: data)) ?? []
    }
    
}
