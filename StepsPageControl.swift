//
//  StepsPageControl.swift
//  IC Covid
//
//  Created by Francesco on 22/01/2021.
//  Copyright © 2021 Francesco Cenciarelli. All rights reserved.
//

import SwiftUI
import Foundation
import UIKit


struct StepsPageControl: UIViewRepresentable {
    
    var stepsNumberOfPages: Int
    
    
    @Binding var stepsCurrentPageIndex: Int
    
    func makeUIView(context: Context) -> UIPageControl{
        let control = UIPageControl()
        control.numberOfPages = stepsNumberOfPages
        control.currentPageIndicatorTintColor = .blue2
        control.pageIndicatorTintColor = UIColor.gray
        
        return control
    }
    
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = stepsCurrentPageIndex
    }
    

}


