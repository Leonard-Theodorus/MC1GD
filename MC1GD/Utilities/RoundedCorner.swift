//
//  RoundedCorner.swift
//  MC1GD
//
//  Created by Sarah Uli Octavia on 03/05/23.
//

import Foundation
import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        if corners.contains(.bottomLeft) {
            let point1 = CGPoint(x: rect.minX, y: rect.maxY)
            let point2 = CGPoint(x: rect.minX, y: rect.minY + radius)
            let point3 = CGPoint(x: rect.minX + radius, y: rect.minY)
            path.move(to: point1)
            path.addLine(to: point2)
            path.addLine(to: point3)
        }
        return Path(path.cgPath)
    }
}
