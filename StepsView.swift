//
//  StepsView.swift
//  IC Covid
//
//  Created by Francesco on 22/01/2021.
//  Copyright © 2021 Francesco Cenciarelli. All rights reserved.
//

import SwiftUI

struct StepsView: View {
    var imageString: String

    var body: some View {
    
            Image(imageString)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipped()
    }
}


#if DEBUG

struct StepsView_Previews: PreviewProvider {
    static var previews: some View {
    
            StepsView(imageString: "man-party-hat-icon-element-party-fun-icon-premium-quality-graphic-design-icon-signs-symbols-collection-icon-109162526")
                
            
        }
        
    }


#endif
