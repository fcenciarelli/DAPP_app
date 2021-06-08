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

struct Step2: View {
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .center, spacing: 40) {
                
                Group {
                    
                    Text("Flip the device, pour boiling water inside the cup until the fill line. Check that water is at more than 80°C by looking at the temperature strip. Insert the device inside.")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 350, height: 150, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.init(color3)))
                    
                            
                    Image("Step2")
                        .scaleEffect(0.5)
                        .frame(width: 320, height: 300, alignment: .center)
                    
                    Text("When ready start the 5 minutes timer:")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 350, height: 100, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.init(color3)))
                }
                
                }
                Spacer()
                
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        
}
