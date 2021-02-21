//
//  StatsRowView.swift
//  TrafficLight
//
//  Created by Jon Vestal on 31/1/21.
//

import SwiftUI

struct StatsRowView: View {
    let stat: Stat
    let host: String
    
    var body: some View {
        HStack {
            Text(stat.type)
            Spacer()
            Text(stat.greenCount.description)
                .foregroundColor(.green)
            Text(stat.yellowCount.description)
                .foregroundColor(.yellow)
            Text(stat.redCount.description)
                .foregroundColor(.red)
        }
        .padding(.horizontal)
    }
}

struct StatsRowView_Previews: PreviewProvider {
    static var stat = Stat.data[0]
    static var previews: some View {
        StatsRowView(stat: stat, host: "Host 0")
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
