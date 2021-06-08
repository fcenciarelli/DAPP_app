//
//  Step 3.swift
//  IC Covid
//
//  Created by Francesco Cenciarelli on 06/06/2021.
//  Copyright © 2021 Francesco Cenciarelli. All rights reserved.
//

import SwiftUI
import Foundation
import UIKit

struct Step3: View {
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .center, spacing: 40) {
            
                Group {
                    Text("Remove the device from the cup and place it on a horizonthal surface and wait for 1 minute.")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 350, height: 150, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.init(color3)))
                    
                    Image("Step3")
                        .scaleEffect(0.5)
                        .frame(width: 350, height: 80, alignment: .center)
                    
                    Text("When ready start the 1 minute timer:")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 350, height: 150, alignment: .center)
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
