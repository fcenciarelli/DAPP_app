//
//  FinalResultPage.swift
//  IC Covid
//
//  Created by Francesco Cenciarelli on 04/03/2021.
//  Copyright © 2021 Francesco Cenciarelli. All rights reserved.
//

import SwiftUI
import Foundation
import UIKit

struct FinalResultPage: View {
    
    @Binding var showFinal: Bool
    
    @Binding var result: CGFloat
    
    
    var body: some View {
        
        ZStack (alignment: .center){
            VStack(alignment: .center, spacing: 10) {
                
                Group {
                    if result > 125 {
                        Text("Your test result is: \n\n\t\tPositive")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    } else {
                        Text("Your test result is: \n\n\t\tNegative")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 371, height: 200, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.init(color2)))
                
    
                
                Group {
                    
                    Text("Your test result can be accessed in the Past Results section")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.init(color4)))
                    
                }
                .frame(width: 371, height: 100, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.init(color4)))
                
                Button (action: {
                    self.showFinal = false
                    
                }) {
                    Text("Go back to the menu")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 100, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.init(color3)))
                }
                
            
                
                
            }
            
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        
        
    }
    
}
