//
//  Step 1.swift
//  IC Covid
//
//  Created by Francesco Cenciarelli on 06/06/2021.
//  Copyright © 2021 Francesco Cenciarelli. All rights reserved.
//

import SwiftUI
import Foundation
import UIKit

struct Step1: View {
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                
                Group {
                    Text("Peel open the swab packaging. Rub it over the tonsils 4 times on each side. Roll the swab around the nostril making 10 circles around it.")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 350, height: 150, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.init(color3)))
                    
                    Text("Remove the blue cap on the top of the device, insert the swab and break it. Leaving the fabric tip inside the tube.")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 350, height: 150, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.init(color3)))
                    
                    
                        Image("Step1")
                            .scaleEffect(0.5)
                            .frame(width: 200, height: 400, alignment: .center)
                }
            
                }
                Spacer()
                
                
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        
}
