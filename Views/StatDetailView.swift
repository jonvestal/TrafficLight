//
//  StatDetailView.swift
//  TrafficLight
//
//  Created by Jon Vestal on 31/1/21.
//

import SwiftUI

struct StatDetailView: View {
    @ObservedObject var statsManager: StatsFetcher  //TODO: this has to be an ugly hack but not sure how to get around it
    var statIndex: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(statsManager.stats[statIndex].type)
                .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                .font(.headline)
                .padding(.vertical)
            twoColumnStack(lhs: "Green", rhs: statsManager.stats[statIndex].greenCount.description, color: .green)
            twoColumnStack(lhs: "Yellow", rhs: statsManager.stats[statIndex].yellowCount.description, color: .yellow)
            twoColumnStack(lhs: "Red", rhs: statsManager.stats[statIndex].redCount.description, color: .red)
            
            Text("Description:")
                .font(.headline)
                .padding(.top, 25)
            Text(statsManager.stats[statIndex].description)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .padding(.top, 5)

            HStack {
                Text("Updated:  ")
                Spacer()
                updateAtText()
            }
            .padding(.vertical)
            .font(.caption)
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {statsManager.fetchStats()} ) {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
    }
    
    func updateAtText() -> some View {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        
        return Text(formatter.string(from: statsManager.stats[statIndex].timestamp))
    }
    
    func twoColumnStack(lhs: String, rhs: String, color: Color) -> some View {
        return HStack {
            Text(lhs)
                .fontWeight(.semibold)
            Spacer()
            Text(rhs)
        }
        .foregroundColor(color)
        .padding(.vertical, 2)
    }
}

struct StatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StatDetailView(statsManager: StatsFetcher_Preview(), statIndex: 0)
        }
    }
}
