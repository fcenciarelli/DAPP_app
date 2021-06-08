//
//  Step 2.swift
//  IC Covid
//
//  Created by Francesco Cenciarelli on 06/06/2021.
//  Copyright © 2021 Francesco Cenciarelli. All rights reserved.
//

import SwiftUI
import Foundation
import UIKit


struct TimerView: View {
    
    @Binding var timeRemaining: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            VStack {
                    Text("Time remaining: " + timeString(time: timeRemaining))
                        .font(.title)
                        .foregroundColor(Color.init(color1))
                        .padding(.horizontal, 20)
                        
        }.onReceive(timer) { time in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } 
        }

    }
    }
    
    func timeString(time: Int) -> String {
            let hours   = Int(time) / 3600
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        }
    
}

