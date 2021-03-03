//
//  HostRowView.swift
//  TrafficLight
//
//  Created by Jon Vestal on 21/2/21.
//

import SwiftUI

struct HostRowView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var textField: String
    
    public var name: String
    
    var fontColor: Color {
        return colorScheme == .dark ? Color.black : Color.black
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(name)")
                .font(.headline)
                TextField("\(textField)", text: $textField)
                    .padding(.all)
                    .background(Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0))
                    .cornerRadius(5.0)
                    .foregroundColor(fontColor)
        }
        .padding(.horizontal, 15)
    }
}

struct HostRowView_Previews: PreviewProvider {
    static var previews: some View {
        HostRowView(textField: .constant("http://127.0.0.1:5000/stats"), name: "URL")
            .previewLayout(.fixed(width: 400, height: 90))
            .colorScheme(.dark)
        
        HostRowView(textField: .constant("http://127.0.0.1:5000/stats"), name: "URL")
            .previewLayout(.fixed(width: 400, height: 90))
            .colorScheme(.light)
    }
}
