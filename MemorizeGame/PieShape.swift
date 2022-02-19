//
//  PieShape.swift
//  MemorizeGame
//
//  Created by Entangled Mind on 18/2/2022.
//

import SwiftUI

struct PieShape: Shape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let centerPoint = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let startPoint = CGPoint(x: rect.midX + CGFloat(radius * cos(startAngle.radians)),
                                 y: rect.midX + CGFloat(radius * sin(startAngle.radians)))
        
        path.move(to: centerPoint)
        path.addLine(to: startPoint)
        path.addArc(
            center: centerPoint,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise)
        path.addLine(to: centerPoint)
        
        return path
    }
    
    
}
