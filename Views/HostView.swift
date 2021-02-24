//
//  HostView.swift
//  TrafficLight
//
//  Created by Jon Vestal on 19/2/21.
//

import SwiftUI

struct HostView: View {
    @Binding var host: Host
    @Binding var isPresented: Bool
    
    @AppStorage("name", store: UserDefaults(suiteName: "group.com.jdv.TrafficLight")) var name: String = ""
    @AppStorage("url", store: UserDefaults(suiteName: "group.com.jdv.TrafficLight")) var url: String = ""

    var body: some View {
        VStack {
            HostRowView(textField: $name, name: "Name")
            HostRowView(textField: $url, name: "URL")
            Spacer()
        }
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
                    self.save()
                    isPresented = false
                }){
                    Text("Update")
                }
            }
        }
    }
    
    func save() {
        host.name = name
        host.url = url
    }
}

struct HostView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HostView(host: .constant(Host(name: "", url: "")),
                     isPresented: .constant(false))
        }
    }
}
