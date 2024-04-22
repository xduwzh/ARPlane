//
//  CustomARViewRepresentable.swift
//  AR Toy Helicopter
//
//  Created by 吴征航 on 2024/4/18.
//

import Foundation
import SwiftUI

struct CustomARViewRepresentable: UIViewRepresentable {
    @EnvironmentObject var controllerData: ControllerData

    func makeUIView(context: Context) -> some UIView {
        let arView = CustomARView(controllerData: controllerData)
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
