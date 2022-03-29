//
//  TestImplementation.swift
//  button_loading_state
//
//  Created by Mariam Korashi on 25.03.22.
//

import SwiftUI

class TestImplementationViewModel: ObservableObject {
    
    @Published var image: Image?
    @Published var buttonState: ButtonState = .idle
    
    func startTask() {
        
        guard buttonState == .idle else {
            if buttonState == .loading {
            self.buttonState = .loadingInterrupted
            } else if buttonState == .loadingInterrupted {
                self.buttonState = .idle
            }
            return
        }
        //show image after 10 seconds and stop loading state
        self.buttonState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.image = Image(systemName: "plus")
            self.buttonState = .idle
        }
    }
}

struct TestImplementation: View {
    
    @StateObject var testImplementationViewModel = TestImplementationViewModel()
    
    var body: some View {
        VStack {
            Text("Test Implementation")
            
            testImplementationViewModel.image
            
            AnimatingButtonWithTimer(buttonState: testImplementationViewModel.buttonState, action: { currentbuttonState  in
                
                testImplementationViewModel.startTask()
                
            } )
            
            Button("Reset") {
                testImplementationViewModel.image = nil
            }
        }
    }
}

struct TestImplementation_Previews: PreviewProvider {
    static var previews: some View {
        TestImplementation()
    }
}
