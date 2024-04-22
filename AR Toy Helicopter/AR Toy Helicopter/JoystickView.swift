//
//  JoystickView.swift
//  AR Toy Helicopter
//
//  Created by 吴征航 on 2024/4/18.
//

import SwiftUI



struct JoystickView: View {
    @State private var location: CGPoint = .zero
    @State private var innerCircleLocation: CGPoint = .zero
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil
    
    @Binding var controllerX: Int
    @Binding var controllerY: Int
    
    private let bigCircleRadius: CGFloat = 80
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                // Update the location based on the translation of the gesture
                var newLocation = startLocation ?? location
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                
                // Calculate the distance between the center of the blue circle and the new location
                let distance = sqrt(pow(newLocation.x - location.x, 2) + pow(newLocation.y - location.y, 2))
                
                // Clamp the new location if it exceeds the radius of the blue circle
                if distance > bigCircleRadius {
                    let angle = atan2(newLocation.y - location.y, newLocation.x - location.x)
                    newLocation.x = location.x + cos(angle) * bigCircleRadius
                    newLocation.y = location.y + sin(angle) * bigCircleRadius
                }
                
                self.location = newLocation
                self.innerCircleLocation = newLocation // Update the green circle location
            }
            .updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location
            }
    }

    var fingerDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                // Calculate the distance between the finger location and the center of the blue circle
                let distance = sqrt(pow(value.location.x - location.x, 2) + pow(value.location.y - location.y, 2))
                
                // Calculate the angle between the center of the blue circle and the finger location
                let angle = atan2(value.location.y - location.y, value.location.x - location.x)
                
                // Calculate the maximum allowable distance within the blue circle
                let maxDistance = bigCircleRadius
                
                // Clamp the distance within the blue circle
                let clampedDistance = min(distance, maxDistance)
                
                // Calculate the new location at the edge of the blue circle
                let newX = location.x + cos(angle) * clampedDistance
                let newY = location.y + sin(angle) * clampedDistance
                
                innerCircleLocation = CGPoint(x: newX, y: newY)
                controllerX = Int(innerCircleLocation.x - location.x)
                controllerY = Int(innerCircleLocation.y - location.y)
            }
            .updating($fingerLocation) { (value, fingerLocation, transaction) in
                fingerLocation = value.location
            }
            .onEnded { value in
                // Snap the smaller circle to the center of the larger circle
                let center = location
                innerCircleLocation = center
                controllerX = Int(innerCircleLocation.x - location.x)
                controllerY = Int(innerCircleLocation.y - location.y)
            }
        
    }
    
    var body: some View {
        ZStack {
                // Larger circle (blue circle)
                Circle()
                    .foregroundColor(.white)
                    .frame(width: bigCircleRadius * 2, height: bigCircleRadius * 2)
                    .position(location)
//                    .opacity(0.5)
//                    .gesture(simpleDrag)
                
                // Smaller circle (green circle)
                Circle()
                    .foregroundColor(.gray)
                    .frame(width: 50, height: 50)
                    .position(innerCircleLocation)
                    .gesture(fingerDrag)
//                    .opacity(0.5)
                
                // Angle text
            }
        
    }
    
    
    
        
}

#Preview {
    JoystickView(controllerX: .constant(10), controllerY: .constant(10))
}
