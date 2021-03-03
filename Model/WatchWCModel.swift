//
//  WatchWCModel.swift
//  TrafficLight WatchKit Extension
//
//  Created by Jon Vestal on 25/2/21.
//

import Foundation
import WatchConnectivity
import SwiftUI

class WatchWCModel: NSObject, WCSessionDelegate, ObservableObject {
    @Published var session: WCSession
    @Published var host: Host!
    @AppStorage("host", store: UserDefaults(suiteName: "group.com.jdv.TrafficLight")) var hostData: Data = Data()

    var storedHost: Host {
        guard let host = try? JSONDecoder().decode(Host.self, from: hostData) else {
            return Host()
        }
        return host
    }

    func save(host: Host) {
        guard let hostData = try? JSONEncoder().encode(host) else {
            print("could not save host")
            return
        }
        print("saved host")
        self.hostData = hostData
    }

    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
        self.host = storedHost
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {

    }

    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        print("received data from phone")
        guard let host = try? JSONDecoder().decode(Host.self, from: messageData) else {
            print("Could not decode host")
            return
        }
        save(host: host)

    }
}
