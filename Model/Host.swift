//
//  Host.swift
//  TrafficLight
//
//  Created by Jon Vestal on 9/1/21.
//

import Foundation
import Alamofire
import SwiftyJSON

public struct Host: Hashable, Identifiable, Codable {
    public var id: UUID
    public var name: String
    public var url: String
    public var lastUpdated: Int = 0
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case url
        case lastUpdated
    }
    
    init(id: UUID = UUID(), name: String, url: String) {
        self.name = name
        self.url = url
        self.id = id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(url)
        hasher.combine(lastUpdated)
    }
    
    public static func == (lhs: Host, rhs: Host) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public mutating func update(from data: Data) {
        self.name = data.name
        self.url = data.url
    }
}

extension Host {
    static var data: Host {
        Host(name: "Host 1", url: "http://localhost:5000/stats")
    }
}

extension Host {
    public struct Data {
        public var name: String = ""
        public var url = ""
    }

    var data: Data {
        return Data(name: name, url: url)
    }
}
