//
//  ContentView.swift
//  SwiftUI_Combine_Sample
//
//  Created by kazunori.aoki on 2021/10/05.
//

// https://www.youtube.com/watch?v=Iu8gsE6ZNQU

import SwiftUI

struct ContentView: View {
    
    // MARK: Variables
    @StateObject private var viewModel = ContentViewModel()
    
    
    // MARK: UI
    var body: some View {
        
        ScrollView {
            
            Button {
                viewModel.startFetch()
            } label: {
                Text("Start")
            }
            .padding(.top)
            
            Text(viewModel.time)
            
            Text(viewModel.seconds)
                .foregroundColor(.gray)
            
            Text("\(viewModel.timeModel.seconds) s")
                .foregroundColor(.orange)
            
            Image("ReceiveValue")
                .resizable()
                .scaledToFit()
                .frame(height: 70)
            
            Image("FinishedCompletion")
                .resizable()
                .scaledToFit()
                .frame(height: 70)
            
            Image("ErrorCompletion")
                .resizable()
                .scaledToFit()
                .frame(height: 70)
        }
        .padding()
        .font(.system(size: 36, weight: .bold))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
