//
//  Capability.swift
//  Ambitions
//
//  Created by Clément on 15/03/2018.
//  Copyright © 2018 Clément. All rights reserved.
//

import Foundation

struct Capability : Codable {

    var text: String
    
    var statChangeKind: Card.CardStatKind?
    var statChangeValue: Int?
    
    init(text: String, statChangeKind: Card.CardStatKind? = nil, statChangeValue: Int? = nil) {
        self.text = text
        self.statChangeKind = statChangeKind
        self.statChangeValue = statChangeValue
    }
}
