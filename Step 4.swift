//
//  Step 4.swift
//  IC Covid
//
//  Created by Francesco Cenciarelli on 06/06/2021.
//  Copyright © 2021 Francesco Cenciarelli. All rights reserved.
//

import SwiftUI
import Foundation
import UIKit

struct Step4: View {
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .center, spacing: 20) {
            
                Group {
                    Text("Push the plunger further until the membrane is outside the device.")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 320, height: 100, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.init(color3)))
                    
                    Text("Bend the tube to break the glass ampule and release the reagents on the membrane.")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 320, height: 100, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.init(color3)))
                    
                            
                    Image("Step4")
                        .scaleEffect(0.5)
                        .frame(width: 320, height: 400, alignment: .center)
                    
                }
            
                }
                Spacer()
                
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        
}
