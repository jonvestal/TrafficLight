//
//  Stat.swift
//  TrafficLight
//
//  Created by Jon Vestal on 6/1/21.
//

import Foundation

struct Stat: Equatable, Hashable, Identifiable {
    public var id: UUID
    public var timestamp: Date
    public var type: String
    public var greenCount: Int
    public var yellowCount: Int
    public var redCount: Int
    public var description: String
    
    init(id: UUID = UUID(), timestamp: Date, type: String, greenCount: Int, yellowCount: Int, redCount: Int, description: String?) {
        self.id = id
        self.timestamp = timestamp
        self.type = type
        self.greenCount = greenCount
        self.yellowCount = yellowCount
        self.redCount = redCount
        self.description = description ?? ""
    }
    
    static func == (lhs: Stat, rhs: Stat) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(greenCount)
        hasher.combine(yellowCount)
        hasher.combine(redCount)
    }
}

extension Stat {
    static var data: [Stat] {
        [
            Stat(timestamp: Date(), type: "Switches", greenCount: 175, yellowCount: 4, redCount: 1,
                 description: "Switches in the network."),
            Stat(timestamp: Date(), type: "Backbones", greenCount: 350, yellowCount: 10, redCount: 2,
                 description: "Backbone circuits in the network."),
            Stat(timestamp: Date(), type: "Services", greenCount: 100, yellowCount: 20, redCount: 0,
                 description: "Total of number of services deployed.")
        ]
    }
}

extension Stat {
    struct Data {
        public var timestamp: Date = Date()
        public var type: String = ""
        public var greenCount: Int = 0
        public var yellowCount: Int = 0
        public var redCount: Int = 0
        public var description: String = ""
    }
    
    var data: Data {
        return Data(timestamp: timestamp, type: type, greenCount: greenCount, yellowCount: yellowCount, redCount: redCount, description: description)
    }
}
