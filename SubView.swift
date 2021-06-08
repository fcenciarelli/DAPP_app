//
//  SubView.swift
//  IC Covid
//
//  Created by Francesco on 22/01/2021.
//  Copyright © 2021 Francesco Cenciarelli. All rights reserved.
//

import SwiftUI

struct Subview: View {
    var imageString: String
    var body: some View {
        Image(imageString)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .clipped()
        
    }
}


#if DEBUG

struct Subview_Previews: PreviewProvider {
    static var previews: some View {
        Subview(imageString: "Laboratorio")
    }
}

#endif
