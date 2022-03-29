//
//  AnimationTimer.swift
//  AnimationProject
//
//  Created by Karin Prater on 29.07.20.
//  Copyright © 2020 Karin Prater. All rights reserved.
//

import Foundation
import Combine

class AnimationTimer: ObservableObject {
    
    @Published var step: Double = 0  // progess seconds
    @Published var isRunning: Bool = false
    
    var subscription = Set<AnyCancellable>()
    
    
    init(timeInterval: Double = 0.1, duration: Double = 2.3) {
        
        Timer.publish(every: timeInterval, on: .main, in: .default)
            .autoconnect()
            
            .filter({ _ in
                return self.isRunning
            })
            .sink { _ in
                if self.step == duration {
                    self.step = 0
                }else {
                    
                    self.step += timeInterval
                    print(self.step)
                }
            }
            .store(in: &subscription)
    }
    
    
    func reset() {
        self.step = 0
    }
    
    func pause() {
        isRunning = false
    }
    
    func cancel() {
        isRunning = false
        step = 0
    }
    
    func start() {
        self.step = 0
        isRunning = true
    }

}














//init(timeInterval: Double = 1, endTime: Int = 5) {
//
//       Timer.publish(every: timeInterval, on: .main, in: .default)
//           .autoconnect()
//           .filter({ _ in
//               return self.isRunning
//           })
//        .sink { _ in
//            if self.step == endTime {
//                self.step = 0
//            }else  {
//                self.step += 1
//            }
//       }.store(in: &subscription)
//}
