//
//  ContentView.swift
//  Offline Alerter
//
//  Created by David Reese on 4/1/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: ContentViewModel = ContentViewModel()
//    @State var connectionState: ConnectionState?
    
    init() {
        
    }
    
    var body: some View {
        HStack {
            if let state = model.connectionState {
                    Text("You are \(state.rawValue).")
                        .bold()
                if model.connectionState == .connected {
                    Image(systemName: "circle.fill")
                        .foregroundColor(.green)
                } else if model.connectionState == .connectedWithoutService {
                    Image(systemName: "circle.fill")
                        .foregroundColor(.yellow)
                } else if model.connectionState == .disconnected {
                    Image(systemName: "circle.fill")
                        .foregroundColor(.red)
                }
                } else {
                    Text("Checking...")
                        .bold()
                    Image(systemName: "circle.fill")
                        .foregroundColor(.orange)
                }
            
        }.padding()
        .frame(minWidth: 300, minHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
