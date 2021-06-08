//
//  Step 5.swift
//  IC Covid
//
//  Created by Francesco Cenciarelli on 06/06/2021.
//  Copyright © 2021 Francesco Cenciarelli. All rights reserved.
//

import SwiftUI
import Foundation
import UIKit

struct Step5: View {
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .center, spacing: 40) {
                Group {
                    Text("Place the device inside the cup of boiling water and wait for 30 minutes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 320, height: 150, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.init(color3)))
                    
                            
                    Image("Step5")
                        .scaleEffect(0.5)
                        .frame(width: 350, height: 300, alignment: .center)
                    
                    Text("When ready start the 30 minute timer:")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 320, height: 150, alignment: .center)
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
