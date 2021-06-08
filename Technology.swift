//
//  Technology.swift
//  IC Covid
//
//  Created by Francesco Cenciarelli on 21/02/2021.
//  Copyright © 2021 Francesco Cenciarelli. All rights reserved.
//

import Foundation
import SwiftUI




struct Technology: View {
    
    @Binding var showTechnology: Bool
    
    let blueBox = UIView(frame: CGRect(x: 100, y: 100, width: 128, height: 128))
//    blueBox;.backgroundColor = .blue
//    blueBox.layer.cornerRadius = 25;
//    blueBox.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                
                HStack(alignment: .center, spacing: 10) {
                    
                    Button(action: {
                        withAnimation {
                            self.showTechnology = false
                        }
                    
                    }) {
                        GoBack()
                        
                    }
                    
                    Group {
                        
                        Text("Technology")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 300, height: 100, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.init(color1)))
                        
                        
                    }
                    

                }
                
                
                HStack(alignment: .center) {
                    
                    Button(action: {
                        withAnimation {
            
                        }
                    }) {
                
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                        Group {
                            Text("LAMP")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 150, height: 100, alignment: .center)
                            }
                        Image("results")
                            .scaleEffect(0.1)
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                        }
                    }.buttonStyle(TechnologyButtonsStyle())
                    
                    Button(action: {
                        withAnimation {
            
                        }
                    }) {
                
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                        Group {
                    
                            Text("RNA Extraction")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 150, height: 100, alignment: .center)
                            }
                        Image("results")
                            .scaleEffect(0.1)
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                        }
                    }.buttonStyle(TechnologyButtonsStyle())
                }
                
                Button(action: {
                    withAnimation {
        
                    }
                }) {
            
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
                    Group {
                
                        Text("Device")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 150, height: 100, alignment: .center)
                        }
                    Image("results")
                        .scaleEffect(0.1)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                    }
                }.buttonStyle(TechnologyDeviceButton())


            }
            }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        }
        
        
    
    
    
        }
        
    
    
    

struct TechnologyButtonsStyle: ButtonStyle {

        func makeBody(configuration: Self.Configuration) -> some View {
          configuration.label
              .font(Font.custom("ProximaNovaAltLight.otf", size: 15))
            .frame(width: 175.5, height: 300)
              .foregroundColor(Color.white)
            .background(Color.init(color2))
            .cornerRadius(30)
        }
      }


struct TechnologyDeviceButton: ButtonStyle {

        func makeBody(configuration: Self.Configuration) -> some View {
          configuration.label
              .font(Font.custom("ProximaNovaAltLight.otf", size: 15))
              .frame(width: 371, height: 350)
              .foregroundColor(Color.white)
            .background(Color.init(color2))
            .cornerRadius(30)
        }
      }




struct GoBack: View {
    
    var body: some View {
        Image(systemName: "arrow.left")
        .resizable()
        .foregroundColor(.white)
        .frame(width: 20, height: 20)
        .padding()
        .background(Color.init(color2))
        .cornerRadius(30)
        
    }
}

