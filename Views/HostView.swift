//
//  HostView.swift
//  TrafficLight
//
//  Created by Jon Vestal on 19/2/21.
//

import SwiftUI

struct HostView: View {
    @Binding var host: Host
    
    var body: some View {
        VStack {
            HostRowView(textField: $host.name, name: "Name")
            HostRowView(textField: $host.url, name: "URL")
            Spacer()
        }
    }
}

struct HostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HostView(host: .constant(Host.data))
        }
    }
}
