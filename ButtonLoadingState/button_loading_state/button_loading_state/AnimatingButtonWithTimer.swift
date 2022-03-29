//
//  ThirdExample.swift
//  button_loading_state
//
//  Created by Mariam Korashi on 02.03.22.
//

import SwiftUI

enum ButtonState {
    case idle
    case loading
    case loadingInterrupted
    
//    func isAnimating() -> Bool {
//        switch self {
//        case .idle:
//            return false
//        case .loading, .loadingInterrupted:
//            return true
//        }
//    }
    
}

struct AnimatingButtonWithTimer: View {
    
    
    var buttonState: ButtonState
    
    var idleTitle: String = "Subscribe"
    var loadingTitle: String = "Adding you to our list..."
    var loadingInterruptedTitle: String = "Tap again to cancel"
    
    var action: (ButtonState) -> ()
    
    init(buttonState: ButtonState, action: @escaping (ButtonState) -> ()) {
        self.buttonState = buttonState
        self.action = action
    }
    
    var body: some View {
        Button(action: changeButtonState) {
            Text(self.title())
                .foregroundColor(.white)
        }
        .buttonStyle(.plain)
        .frame(width: 180)
        .padding()
        .background(animatingBackground(buttonState: buttonState))//.clipped()
        .saturation(buttonState == .loadingInterrupted ? 0 : 1)
    }
    
    func changeButtonState() {
        print("Button pressed")
        //print(buttonState)
        action(buttonState)
        
        print(buttonState)
    }
    
    func title() -> String {
        switch buttonState {
            case .idle:
                return idleTitle
            case .loading:
                return loadingTitle
            case .loadingInterrupted:
                return loadingInterruptedTitle
        }
    }
}

fileprivate struct animatingBackground: View {
    
    var buttonState: ButtonState
    
    @State private var animationProgressA: CGFloat = 0.0
   // @State private var animationProgressB: CGFloat = 0
    
    @State private var animationProgressC: CGFloat = 0
   // @State private var animationProgressD: CGFloat = 0
    
    let animationA = Animation.easeIn(duration: 1.7)
    
    let animationC = Animation.easeOut(duration: 1.7)
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    let duration: Int = 15
    @State var step: Int = 0 //0.1 seconds

    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading){
                Color(0xd8251d)
                drawRectangle(width: geometry.size.width, animationProgress: animationProgressA, color: Color(0xfa2921))
                drawRectangle(width: geometry.size.width, animationProgress: animationProgressC, color: Color(0xd8251d))
            }
                .frame(width: geometry.size.width)
                .cornerRadius(6)
        }
        
        .onChange(of: buttonState, perform: checkState)
        
        .onReceive(timer) { _ in
            
            guard buttonState != .idle else {
                return
            }
            
            if step == duration {
                step = 0
                animationProgressA = 0
                animationProgressC = 0
                
            } else {
                step += 1
            }
            
            if step == 1 {
                withAnimation(animationA) {
                    if buttonState != .idle {
                        animationProgressA = 1
                    }
                }
            } else if step == 11 {
                withAnimation(animationC) {
                    if buttonState != .idle {
                        animationProgressC = 1
                    }
                }
            }
        }
    }
    
    public func checkState(state: ButtonState) {
       
        if state == .idle  {
            step = 0
            animationProgressA = 0
            animationProgressC = 0
        }
    }
    
    @ViewBuilder
    public func drawRectangle(width: CGFloat, animationProgress: CGFloat, color: Color) -> some View {
        let initialOffset = width
        let movingOffset = width + initialOffset
            Rectangle()
                .fill(color)
                .frame(width: initialOffset)
                .offset(x:  animationProgress * movingOffset - initialOffset)
    }
    
//    private func animateViews(state: ButtonState) {
//
//        withAnimation(state.isAnimating() ? animationA : nil) {
//            if state != .idle {
//                animationProgressA = 1
//                print("buttonState is 0")
//                print(self.animationProgressA)
//            }
//        }
//
//        withAnimation(Animation.easeOut(duration: 1.7).delay(2.1).repeatForever(autoreverses: false)) {
//            if state != .idle {
//                animationProgressC = 1
//
//            } else {
//                animationProgressC = 0
//            }
//        }
//
//    }
}


extension Color {
  init(_ hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 8) & 0xFF) / 255,
      blue: Double(hex & 0xFF) / 255,
      opacity: alpha
    )
  }
}


//struct AnimatingButtonWithTimer_Previews: PreviewProvider {
//    static var previews: some View {
//
//        AnimatingButtonWithTimer(action: { currentbuttonState  in
//
//            if currentbuttonState == ButtonState.idle {
//                return ButtonState.loading
//            } else if currentbuttonState == ButtonState.loading {
//                return ButtonState.loadingInterrupted
//            } else {
//                return ButtonState.idle
//            }
//
//        } )
//    }
//}
