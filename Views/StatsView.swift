//
//  StatsView.swift
//  TrafficLight
//
//  Created by Jon Vestal on 31/1/21.
//

import Foundation
import SwiftUI

struct StatsView: View {
    @State private var isPresented = false
    @ObservedObject var statsManager = StatsFetcher(host: Host(name: "", url: ""))
    
    var body: some View {
        VStack {
            if !statsManager.stats.isEmpty {
                List {
                    Section(header: Text("\(statsManager.host.name)"), footer: updateAtText().font(.caption)) {
                        ForEach(statsManager.stats) { stat in
                            NavigationLink(destination: StatDetailView(statsManager: statsManager, statIndex: index(for: stat, in: statsManager))) {
                                StatsRowView(stat: stat, host: statsManager.host.name)
                            }
                        }
                    }
                }
                .onAppear {
                    statsManager.fetchStats()
                }
                
            } else {
                Text("You need to add a host first.")
                Button(action: {isPresented = true}) {
                    Text("Host")
                }
            }
        }
        .toolbar {
            ToolbarItem {
                Button(action: {
                    isPresented = true
                }) {
                    Text("Host")
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            NavigationView {
                HostView(host: $statsManager.host)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(action: {
                                isPresented = false
                            }){
                                Text("Cancel")
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button(action: {
                                statsManager.fetchStats()
                                isPresented = false
                            }){
                                Text("Update")
                            }
                        }
                    }
            }
        }
    }
    
    private func index(for stat: Stat, in statsManager: StatsFetcher) -> Int {
        guard let statIndex = statsManager.stats.firstIndex(where: { $0.id == stat.id }) else {
            fatalError("Can't find host in array")
        }
        return statIndex
    }
    
    func updateAtText() -> some View {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        
        return Text(formatter.string(from: statsManager.updatedAt))
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StatsView(statsManager: StatsFetcher_Preview())
        }
    }
}
