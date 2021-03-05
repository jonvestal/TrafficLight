//
//  PhoneStatsView.swift
//  TrafficLight
//
//  Created by Jon Vestal on 31/1/21.
//

import Foundation
import SwiftUI
import Combine

class Model: ObservableObject {
    @Published var statsManager: StatsFetcher = StatsFetcher()
    
    var anyCancellable: AnyCancellable?
    
    init() {
        anyCancellable = statsManager.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
}

struct PhoneStatsView: View {
    @State private var isPresented = false
    @StateObject var model: Model = Model()
    
    @ObservedObject var wcModel = PhoneWCModel()
    
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
                Text("You need to add a host first.")
                Button(action: { isPresented = true }, label: {
                    Text("Host")
                })
            }
            #if DEBUG
            Spacer()
            Text("Connected \(wcModel.isConnected)")
            #endif
        }
        .navigationTitle("TrafficLight Stats")
        .toolbar {
            ToolbarItem {
                Button(action: { isPresented = true }, label: {
                    Text("Host")
                })
            }
        }
        .sheet(isPresented: $isPresented, onDismiss: { model.statsManager.fetchStats() }, content: {
            NavigationView { HostView(isPresented: $isPresented) }
        })
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

//struct StatsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            StatsView(model: .constant(StatsFetcher_Preview()))
//        }
//    }
//}
