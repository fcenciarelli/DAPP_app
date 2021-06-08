//
//  StepsOnboardingView.swift
//  IC Covid
//
//  Created by Francesco on 22/01/2021.
//  Copyright © 2021 Francesco Cenciarelli. All rights reserved.
//


import SwiftUI
import Foundation
import UIKit


struct StepsOnboardingView: View {
    
    @Binding var showSteps: Bool
    @Binding var showFinal: Bool
    @Binding var showTakePhoto: Bool
    
    @State private var timeRemaining: Int = 500
    
    @State var startTimer: Bool = false
    
    var stepsviews = [
        UIHostingController(rootView: StepsView(imageString: "step1")),
        UIHostingController(rootView: StepsView(imageString: "step2")),
        UIHostingController(rootView: StepsView(imageString: "step3")),
        UIHostingController(rootView: StepsView(imageString: "step4")),
        UIHostingController(rootView: StepsView(imageString: "step5")),
        UIHostingController(rootView: StepsView(imageString: "step5"))
    
    ]
    
    var titles = ["Step 1", "Step 2", "Step 3", "Step 4", "Step 5", "Step 6"]
    var captions = ["Insert the swab inside the device opening by peeling of the protective film and after two minutes push the swab, breaking the membrane", "Press button 1", "Press the first tab and press button 2", "place the handwarmer and wait 20 minutes", "lift tab1 wait 2 minutes and close it. Then lift tab 2 and press button 3", "Take a picture of the device to get immediately your results"]
    
    @State var stepsCurrentPageIndex = -1
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        
        if stepsCurrentPageIndex == -1 {
            
            VStack(alignment: .center) {
                
                InstructionsPage()
                
                Button(action: {
                        withAnimation {
                            self.stepsCurrentPageIndex = 1
                        }
                    }) {
                        Text("Start")
                        
                    } .buttonStyle(FinalMenuButtonStyle())
                      .cornerRadius(30.0)
            }
            
        } else if stepsCurrentPageIndex == 1 {
            
            ZStack {
                
                VStack(alignment: .center, spacing: 20) {
                    
                    Step1()
                    
                    Button(action: {
                            withAnimation {
                                self.stepsCurrentPageIndex = 2
                            }
                        }) {
                            Text("Next step")
                            
                        } .buttonStyle(FinalMenuButtonStyle())
                          .cornerRadius(30.0)
                    
                }
                
            }
            
        } else if stepsCurrentPageIndex == 2 {
            ZStack {
                VStack(alignment: .center, spacing: 20) {
                    
                    
                    Step2()
                    
                    if self.startTimer == false {
                        Button(action: {
                            self.timeRemaining = 300
                            self.startTimer = true
                            }) {
                                Text("Start the timer")
                                
                            } .buttonStyle(TimerButtonStyle())
                              .cornerRadius(30.0)
                    }
                    
                    if startTimer {
                        TimerView(timeRemaining: self.$timeRemaining)
                    }
                    

                    Button(action: {
                            withAnimation {
                                self.stepsCurrentPageIndex = 3
                                self.startTimer = false
                            }
                        }) {
                            Text("Next step")
                            
                        } .buttonStyle(FinalMenuButtonStyle())
                          .cornerRadius(30.0)
                    
                }
            }
            
            
        } else if stepsCurrentPageIndex == 3 {
            
            ZStack {
                VStack(alignment: .center, spacing: 20) {
                    
                    Step3()
                    
                    if self.startTimer == false {
                        Button(action: {
                            self.timeRemaining = 60
                            self.startTimer = true
                            }) {
                                Text("Start the timer")
                                
                            } .buttonStyle(TimerButtonStyle())
                              .cornerRadius(30.0)
                    }
                    
                    if startTimer {
                        TimerView(timeRemaining: self.$timeRemaining)
                    }
                    
                    
                    Button(action: {
                            withAnimation {
                                self.stepsCurrentPageIndex = 4
                                self.startTimer = false
                            }
                        }) {
                            Text("Next step")
                            
                        } .buttonStyle(FinalMenuButtonStyle())
                          .cornerRadius(30.0)
                    
                }
            }
            
            
            
        } else if stepsCurrentPageIndex == 4 {
            
            ZStack {
                
                
                VStack(alignment: .center, spacing: 20) {
                    
                    Step4()
                    
                    Button(action: {
                            withAnimation {
                                self.stepsCurrentPageIndex = 5
                            }
                        }) {
                            Text("Next step")
                            
                        } .buttonStyle(FinalMenuButtonStyle())
                          .cornerRadius(30.0)
                    
                }
            }
            
            
            
        } else if stepsCurrentPageIndex == 5 {
            
            
            ZStack {
                
                VStack(alignment: .center, spacing: 20) {
                    
                    Step5()
                    
                    if self.startTimer == false {
                        Button(action: {
                            self.timeRemaining = 1800
                            self.startTimer = true
                            }) {
                                Text("Start the timer")
                                
                            } .buttonStyle(TimerButtonStyle())
                              .cornerRadius(30.0)
                    }
                    
                    if startTimer {
                        TimerView(timeRemaining: self.$timeRemaining)
                    }
                    
                    
                    Button(action: {
                            withAnimation {
                                self.showSteps = false
                                self.showTakePhoto = true
                            }
                        }) {
                            Text("Next step")
                            
                        } .buttonStyle(FinalMenuButtonStyle())
                          .cornerRadius(30.0)
                    
                }
            }
            
            
        } else if stepsCurrentPageIndex == 7 {
            
            Button(action: {
                    withAnimation {
                        self.stepsCurrentPageIndex = 0
                    }
                }) {
                    Text("Start")
                    
                } .buttonStyle(FinalMenuButtonStyle())
                  .cornerRadius(30.0)
            
            
        } else {
            
            ZStack (alignment: .center){
                VStack(alignment: .center) {
                    
                    Group {
                    Text(titles[stepsCurrentPageIndex])
                        .font(.title)
                        .foregroundColor(Color.init(color1))
                        .frame(width: 300, height: 50, alignment: .top)
                    Text(captions[stepsCurrentPageIndex])
                        .font(.headline)
                        .foregroundColor(Color.init(color4))
                        .frame(width: 300, height: 50, alignment: .center)
                        .lineLimit(nil)
                    }
                    
                    
                    StepsPageViewController(stepsCurrentPageIndex: $stepsCurrentPageIndex, viewControllers: stepsviews)
                    .frame(width: 300, height: 500)
                
                    
                    StepsPageControl(stepsNumberOfPages: stepsviews.count, stepsCurrentPageIndex: $stepsCurrentPageIndex)
                    
                    if stepsCurrentPageIndex == 6 {
                    
                        Button(action: {
                                withAnimation {
                                    self.showSteps = false
                                    self.showTakePhoto = true
                                }
                            }) {
                            
                            HStack {
                                
                                Group {
                                    Text("Take a picture of the result")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(width: 250, height: 30, alignment: .center)
                                }
                                
                                Image(systemName: "camera")
                                    .scaleEffect(1.5)
                                    .foregroundColor(.white)
                                    .frame(width: 70, height: 70, alignment: .center)
                                
                                }
                            }
                        .cornerRadius(30.0)
                        .frame(width: 371, height: 80, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.init(color4)))
                        } else {
                    
                    Button(action: {
                        if self.stepsCurrentPageIndex+1 == self.stepsviews.count{
                            self.stepsCurrentPageIndex = 0
                        } else {
                            self.stepsCurrentPageIndex += 1
                            
                        }}) {
                        ButtonContent()
                        }
                }

                }
            }
            .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            
        }
        
        }
    }


struct StepsOnboardingView_Previews: PreviewProvider {
        static var previews: some View {
    OnboardingView()
    }
}


