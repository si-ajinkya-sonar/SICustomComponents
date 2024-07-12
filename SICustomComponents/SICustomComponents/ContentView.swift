//
//  ContentView.swift
//  SICustomComponents
//
//  Created by Nausheen Khan on 12/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showUpdatePopup = false
    @State private var updateType: SIUpdatePopupView.UpdateType = .optionalUpdate
    
    var body: some View {
        VStack(spacing: 20) {
            
            Button {
                if updateType == .forceUpdate {
                    updateType = .optionalUpdate
                } else if updateType == .optionalUpdate {
                    updateType = .forceUpdate
                }
            } label: {
                Text("Change Popup Type")
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(10)
            }
            
            Button {
                showUpdatePopup.toggle()
            } label: {
                Text("Toggle Popup Display")
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
        }
        .padding()
        .updatePopup(isPresented: $showUpdatePopup) {
            SIUpdatePopupView(updateType: updateType, isPresented: $showUpdatePopup)
        }
    }
}

#Preview {
    ContentView()
}
