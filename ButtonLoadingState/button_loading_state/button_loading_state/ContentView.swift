//
//  ContentView.swift
//  button_loading_state
//
//  Created by Mariam Korashi on 24.02.22.
//

import SwiftUI

struct ContentView: View {
    
    var colors: [Color] = [Color(red: 0.980, green: 0.16, blue: 0.13), Color(red: 0.988, green: 0.54, blue: 0.533)]
    @State var index: Int = 0
        
    @State var progress: CGFloat = 0
    
    var body: some View {
        VStack {
            
            TestImplementation()
            
        }
    }
    
  
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
