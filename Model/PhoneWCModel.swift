//
//  File.swift
//  TrafficLight
//
//  Created by Jon Vestal on 25/2/21.
//

import Foundation
import WatchConnectivity
import SwiftUI

class PhoneWCModel: NSObject, WCSessionDelegate, ObservableObject {
    @AppStorage("host", store: UserDefaults(suiteName: "group.com.jdv.TrafficLight")) var hostData: Data = Data()
    @Published var isConnected = "No"

    private var host: Host!

    var session: WCSession
    
    var storedHost: Host {
        guard let host = try? JSONDecoder().decode(Host.self, from: hostData) else {
            return Host()
        }
        return host
    }
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
        self.host = storedHost
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {

    }

    func sessionReachabilityDidChange(_ session: WCSession) {
        DispatchQueue.main.async {
            self.isConnected = session.isReachable ? "Yes" : "No"
            self.updateSettings()
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
   
    func sessionDidDeactivate(_ session: WCSession) {
       
    }
   
    func updateSettings() {
        if session.isReachable {
            session.sendMessageData(hostData, replyHandler: nil, errorHandler: { error in
                print(error.localizedDescription)
            })
        }
    }
}
