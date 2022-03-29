//
//  ThirdExample.swift
//  button_loading_state
//
//  Created by Mariam Korashi on 02.03.22.
//

import SwiftUI

struct AnimatingButton: View {
    
    enum ButtonState {
        case idle
        case loading
        case loadingInterrupted
        
        func title() -> String {
            switch self {
            case .idle:
                return "Subscribe"
            case .loading:
                return "Adding you to our list..."
            case .loadingInterrupted:
                return "Tap again to cancel"
            }
        }
        
        func isAnimating() -> Bool {
            switch self {
            case .idle:
                return false
            case .loading, .loadingInterrupted:
                return true
            }
        }
        
    }
    
    @State var buttonState: ButtonState = .idle
    
    var body: some View {
        Button(action: changeButtonState ){
            Text(buttonState.title())
                .foregroundColor(.white)
        }
        .buttonStyle(.plain)
        .frame(width: 180)
        .padding()
        .background(animatingBackground(buttonState: $buttonState))//.clipped()
        .saturation(buttonState == .loadingInterrupted ? 0 : 1)
    }
    
    func changeButtonState() {
        print("Button pressed")
        //print(buttonState)
        
        if buttonState == .idle {
            buttonState = .loading
        } else if buttonState == .loading {
            buttonState = .loadingInterrupted
        } else if buttonState == .loadingInterrupted {
            buttonState = .idle
        }
        
        print(buttonState)
    }
}

extension Animation {
    func `repeat`(while expression: Bool, autoreverses: Bool = false) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}

fileprivate struct animatingBackground: View {
    
   
    
    @Binding var buttonState: AnimatingButton.ButtonState
    
    @State private var animationProgressA: CGFloat = 0.0
   // @State private var animationProgressB: CGFloat = 0
    
    @State private var animationProgressC: CGFloat = 0
   // @State private var animationProgressD: CGFloat = 0
    
    let animationA = Animation.easeIn(duration: 1.7).repeatForever(autoreverses: false)
    
    let animationC = Animation.easeOut(duration: 1.7).repeatForever(autoreverses: false)
    
   // Animation.easeOut(duration: 1.7).delay(1.5).repeatForever(autoreverses: false)

    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading){
                Color(0xd8251d)
                    drawRectangle(width: geometry.size.width, animationProgress: animationProgressA)
                    //drawB(width: geometry.size.width)
                   // drawRectangle(width: geometry.size.width, animationProgress: animationProgressC)
                    //drawD(width: geometry.size.width)
            }
                .frame(width: geometry.size.width)
                .cornerRadius(6)
        }
        .onChange(of: buttonState, perform: animateViews)
        
    }
    
    @ViewBuilder
    public func drawRectangle(width: CGFloat, animationProgress: CGFloat) -> some View {
        let initialOffset = width
        let movingOffset = width + initialOffset
            Rectangle()
                .fill(Color(0xfa2922))
                .frame(width: initialOffset)
                .offset(x: animationProgress * movingOffset - initialOffset )
    }
    
    private func animateViews(state: AnimatingButton.ButtonState) {
        
        print(animationProgressA)
        //print(animationProgressC)
        
       // withAnimation(animationA.repeat(while: state.isAnimating())) {
        withAnimation(state.isAnimating() ? animationA : nil) {
            if state != .idle {
                animationProgressA = 1
                print("buttonState is 0")
                print(self.animationProgressA)
            } else {
                animationProgressA = 0
            }
        }
        
        
//        withAnimation(Animation.easeIn(duration: 2.9).delay(2.3).repeatForever(autoreverses: false)) {
//            animationProgressB = 1
//        }

//        withAnimation(Animation.easeOut(duration: 1.7).delay(2.1).repeatForever(autoreverses: false)) {
//            if state != .idle {
//                animationProgressC = 1
//
//            } else {
//                animationProgressC = 0
//            }
//        }

//        withAnimation(Animation.easeOut(duration: 2.7).delay(3.4).repeatForever(autoreverses: false)) {
//            animationProgressD = 1
//        }
    }
}


struct AnimatingButton_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingButton()
    }
}
