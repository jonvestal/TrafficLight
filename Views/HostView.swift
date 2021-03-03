//
//  HostView.swift
//  TrafficLight
//
//  Created by Jon Vestal on 19/2/21.
//

import SwiftUI

class HostViewModel: ObservableObject {
    @AppStorage("host", store: UserDefaults(suiteName: "group.com.jdv.TrafficLight")) var hostData: Data = Data()
    @Published var host: Host!
    
    var storedHost: Host {
        guard let host = try? JSONDecoder().decode(Host.self, from: hostData) else { return Host() }
        return host
    }
    
    init() {
        
        self.host = storedHost
    }
    
    func save() {
        let host = Host(name: self.host.name, url: self.host.url)
        guard let hostData = try? JSONEncoder().encode(host) else { return }
        self.hostData = hostData
    }
}

struct HostView: View {
    @Binding var isPresented: Bool
    @ObservedObject var model = HostViewModel()

    var body: some View {
        VStack {
            HostRowView(textField: $model.host.name, name: "Name")
            HostRowView(textField: $model.host.url, name: "URL")
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: {
                    isPresented = false
                }, label: {
                    Text("Cancel")
                })
            }
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {
                    self.model.save()
                    isPresented = false
                }, label: {
                    Text("Update")
                })
            }
        }
    }
}

//struct HostView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            HostView(host: .constant(Host(name: "", url: "")),
//                     isPresented: .constant(false))
//        }
//    }
//}
