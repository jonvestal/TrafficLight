//
//  StatsFetcher.swift
//  TrafficLight
//
//  Created by Jon Vestal on 6/1/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI

public class StatsFetcher: ObservableObject, Identifiable {
    @Published var stats: [Stat] = []
    @Published var fetchError: Bool = false
    @Published var updatedAt: Date = Date()
    @Published var host: Host!
    @AppStorage("host", store: UserDefaults(suiteName: "group.com.jdv.TrafficLight")) var hostData: Data = Data()
    
    var storedHost: Host {
        guard let host = try? JSONDecoder().decode(Host.self, from: hostData) else {
            return Host()
        }
        return host
    }
    
    init() {
        self.host = storedHost
        self.fetchStats()
        
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true, block: { _ in
            self.fetchStats()
        })
    }
    
    func save() {
        let host = Host(name: self.host.name, url: self.host.url)
        guard let hostData = try? JSONEncoder().encode(host) else { return }
        self.hostData = hostData
    }
    
    func fetchStats() {
        self.host = storedHost
        if !host.url.isEmpty {
            AF.request(host.url).responseJSON { response in
                switch response.result {
                case .success(let value):
                    self.fetchError = false
                    let json = JSON(value)

                    let stats = json["stats"].arrayValue
                    var statsArray: [Stat] = []
                    for stat in stats {
                        let newStat = Stat(timestamp: Date(timeIntervalSince1970: stat["timestamp"].doubleValue),
                                           type: stat["type"].string ?? "Unknown",
                                           greenCount: stat["greenCount"].intValue,
                                           yellowCount: stat["yellowCount"].intValue,
                                           redCount: stat["redCount"].intValue,
                                           description: stat["description"].string ?? "No description provided")
                        statsArray.append(newStat)
                    }
                    self.updatedAt = Date()
                    self.stats = statsArray

                case .failure(let error):
                    print(error)
                    self.fetchError = true
                }
            }
        }
    }
}

//public class StatsFetcher_Preview: StatsFetcher {
//    init() {
//        super.init(host: Host(name: "Host 1", url: "http://127.0.0.1/stats"))
//        self.stats.append(Stat(timestamp: Date(), type: "Stat 1", greenCount: 10, yellowCount: 5, redCount: 2, description: "Description"))
//        self.stats.append(Stat(timestamp: Date(), type: "Stat 2", greenCount: 100, yellowCount: 2134, redCount: 234, description: "Description"))
//    }
//}
