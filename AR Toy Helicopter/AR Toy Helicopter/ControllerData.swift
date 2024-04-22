//
//  ControllerData.swift
//  AR Toy Helicopter
//
//  Created by 吴征航 on 2024/4/18.
//

import Foundation

class ControllerData: ObservableObject{
    @Published var leftStick = 0;
    @Published var rightStickX = 0;
    @Published var rightStickY = 0;
    @Published var planeSet = false;
}
