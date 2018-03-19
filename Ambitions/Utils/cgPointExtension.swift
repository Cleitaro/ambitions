//
//  cgPointExtension.swift
//  Ambitions
//
//  Created by Clément on 19/02/2018.
//  Copyright © 2018 Clément. All rights reserved.
//

import UIKit

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x + dx, y: y + dy)
    }
}
