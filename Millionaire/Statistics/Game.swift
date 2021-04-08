//
//  Game.swift
//  Millionaire
//
//  Created by Юрий Егоров on 07.04.2021.
//

import Foundation

struct Record {
    let date: Date
    let score: Int
}

final class Game {
    
    static let shared = Game()
    
    private(set) var records: [Record] = []
    
    private init() { }
    
    func addRecord(_ record: Record) {
        self.records.append(record)
    }
    
    func clearRecords() {
        self.records = []
    }
}
