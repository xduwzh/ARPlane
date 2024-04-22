//
//  ContentView.swift
//  AR Toy Helicopter
//
//  Created by 吴征航 on 2024/4/18.
//

import SwiftUI

struct ContentView: View {
    @StateObject var controller = ControllerData()
    
    var body: some View {
        ZStack{
            CustomARViewRepresentable().environmentObject(controller)
            
            if controller.planeSet == true{
                JoystickView(controllerX: $controller.leftStick, controllerY:.constant(0) )
                    .position(CGPoint(x: 300.0, y: 550.0))

                JoystickView(controllerX: $controller.rightStickY, controllerY: $controller.rightStickX)
                    .position(CGPoint(x: 300.0, y: 1100.0))
            }
            
        }
        .ignoresSafeArea()
        
            
    }
}

#Preview {
    ContentView()
}
