//
//  SplashView.swift
//  button_loading_state
//
//  Created by Mariam Korashi on 25.02.22.
//

import SwiftUI

struct SplashView: View {
    
    @State private var prevColor: Color // Stores background color
    @ObservedObject var colorStore: ColorStore // Send new color updates

    @State var layers: [(Color,CGFloat)] = [] // New Color & Progress
    
    init(color: Color) {
        self._prevColor = State<Color>(initialValue: color)
        self.colorStore = ColorStore(color: color)
    }

    var body: some View {
        Rectangle()
            .foregroundColor(self.prevColor)
            .overlay(
                ZStack {
                    ForEach(layers.indices, id: \.self) { x in
                        SplashShape(progress: self.layers[x].1)
                            .foregroundColor(self.layers[x].0)
                    }
                }

                ,alignment: .leading)
            .onReceive(self.colorStore.$color) { color in
                // Animate color update here
                self.layers.append((color, 0))

                withAnimation(.easeInOut(duration: 0.7)) {
                    self.layers[self.layers.count-1].1 = 1.0
                }
            }
    }

}

class ColorStore: ObservableObject {
    @Published var color: Color
    
    init(color: Color) {
        self.color = color
    }
}
