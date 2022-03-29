//
//  SecondExample.swift
//  button_loading_state
//
//  Created by Mariam Korashi on 01.03.22.
//

import SwiftUI

struct SecondExample: View {
    
    @State private var enabled = false
    
    var colors: [Color] = [Color(red: 0.980, green: 0.16, blue: 0.13), Color(red: 0.988, green: 0.54, blue: 0.533)]
    
    @State var index: Int = 0
    
    @State var layers: [(Color,CGFloat)] = [] // New Color & Progress
    
    @State private var prevColor: Color // Stores background color
    @ObservedObject var colorStore: ColorStore // Send new color updates
    
    init(color: Color) {
        self._prevColor = State<Color>(initialValue: color)
        self.colorStore = ColorStore(color: color)
    }
    
    
    var body: some View {
        
        Button("Click me", action: clicked )
                .background(self.prevColor)
                .foregroundColor(.white)
                .overlay (
                        ZStack {
                            ForEach(layers.indices, id: \.self) { index in
                                SplashShape(progress: layers[index].1)
                                    .foregroundColor(layers[index].0)
                            }
                        }
                        ,alignment: .leading)
                   .onReceive(self.colorStore.$color) { color in
                       //clicked()
                       self.layers.append((color, 0))
               
                       withAnimation(.easeInOut(duration: 0.7)) {
                           self.layers[self.layers.count-1].1 = 1.0
                       }
                       
                      // self.layers.append((color, 0))
                  }
        
                    //.background(enabled ? Color(red: 0.988, green: 0.54, blue: 0.533) : Color(red: 0.980, green: 0.16, blue: 0.13))
                //TODO: change the background colour to moving red
                   // .animation(.linear.repeatCount(10), value: enabled)
                    //.transition(AnyTransition.opacity.combined(with: .slide))
                    //.cornerRadius(40)
                   // .padding(.horizontal, 20)
    }
    
    func clicked() {
        print("clicked")
        self.index = (self.index + 1) % self.colors.count
        //enabled.toggle()
        
        // Animate color update here
//        self.layers.append((self.prevColor, 0))
////
//        withAnimation(.easeInOut(duration: 0.7)) {
//            self.layers[self.layers.count-1].1 = 1.0
//        }

        // wait for 1 second
//                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
//                    // Back to normal with ease animation
//                    withAnimation(.linear){
//                        self.enabled.toggle()
//                    }
//                })
    }
}

struct SecondExample_Previews: PreviewProvider {
    static var previews: some View {
        SecondExample(color: .red)
    }
}
