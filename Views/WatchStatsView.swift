//
//  WatchStatsView.swift
//  TrafficLight WatchKit Extension
//
//  Created by Jon Vestal on 25/2/21.
//

import Foundation
import SwiftUI
import Combine

class Model: ObservableObject {
    @Published var statsManager: StatsFetcher = StatsFetcher()
    
    var anyCancellable: AnyCancellable?
    
    var wcModel = WatchWCModel()
    
    init() {
        anyCancellable = statsManager.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
}

struct WatchStatsView: View {
    @State private var isPresented = false
    @StateObject var model: Model = Model()
    
    var body: some View {
        VStack {
            if !model.statsManager.host.url.isEmpty {
                List {
                    Section(header: Text("\(model.statsManager.host.name)"), footer: updateAtText().font(.caption)) {
                        ForEach(model.statsManager.stats) { stat in
                            NavigationLink(destination: StatDetailView(statsManager: model.statsManager,
                                                                       statIndex: index(for: stat, in: model.statsManager))) {
                                StatsRowView(stat: stat)
                            }
                        }
                    }
                }
                .onAppear {
                    model.statsManager.fetchStats()
                }
                
            } else {
                Text("You need to add a host first from the paired iPhone.")
            }
        }
        .navigationTitle("Stats")
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

        return Text(formatter.string(from: model.statsManager.updatedAt))
    }
}

// struct StatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            StatsView(model: .constant(StatsFetcher_Preview()))
//        }
//    }
// }
