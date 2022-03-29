//
//  SplashShape.swift
//  button_loading_state
//
//  Created by Mariam Korashi on 01.03.22.
//

import SwiftUI

struct SplashShape: Shape {
    
    var progress: CGFloat
    
    var animatableData: CGFloat {
        get { return progress }
        set { self.progress = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0)) // Top Left
        path.addLine(to: CGPoint(x: rect.width * progress, y: 0)) // Top Right
        path.addLine(to: CGPoint(x: rect.width * progress, y: rect.height)) // Bottom Right
        path.addLine(to: CGPoint(x: 0, y: rect.height)) // Bottom Left
        path.closeSubpath() // Close the Path
        return path
    }
}

//struct SplashShape_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashShape()
//    }
//}
