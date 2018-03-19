//
//  Card.swift
//  Ambitions
//
//  Created by Clément on 16/02/2018.
//  Copyright © 2018 Clément. All rights reserved.
//

import Foundation
import UIKit

class Card : Codable, CustomStringConvertible, Equatable {
    
    var description: String {return "\(cardType) - \(fullName)"}
    
    var fullName : String
    var name : String
    var cardType : CardType
    var capabilities : [Capability]
    var shapes : [Shape]
    var firstAfinity : Afinities?
    var secondAfinity : Afinities?
    var isUnique = false
    var enabledInCollection = true
    
    enum CardStatKind : Int, Codable {
        case life
        case resistance
        case attack
    }
    
    enum Shape : String, Comparable, Codable {
        static func <(lhs: Card.Shape, rhs: Card.Shape) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
        
        case human
        case beast
        case elemental
    }
    
    enum CardType : String, Codable {
        case hero
        case ally
        case equipment
        case ability
        case ambition
        
        static var count = 5
        
        var sectionIndex: Int {
            switch self {
            case .hero:
                return 0
            case .ally:
                return 1
            case .equipment:
                return 2
            case .ability:
                return 3
            case .ambition:
                return 4
            }
        }
        
        func getCardColor() -> UIColor {
            switch self {
                case .hero:
                    return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                case .ally:
                    return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                case .ambition:
                    return #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
                case .equipment:
                    return #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                case .ability:
                    return #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            }
        }
    }
    
    enum Afinities : String, Codable {
        case faith
        case darkness
        case nature
        case technology
        case magic
        case savage
    }
    
    init(fullName: String,
         name: String,
         cardType: CardType,
         capabilities : [Capability],
         shapes : [Shape],
         firstAfinity: Afinities? = nil,
         secondAfinity : Afinities? = nil,
         isUnique : Bool = false)
    {
        self.fullName = fullName
        self.name = name
        self.cardType = cardType
        self.capabilities = capabilities
        self.shapes = shapes
        self.firstAfinity = firstAfinity
        self.secondAfinity = secondAfinity
        self.isUnique = isUnique
    }
    
    
    //MARK: - Equatable Protocole
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.fullName == rhs.fullName
    }
}

extension Array where Element: Comparable {
    func containsAtLeastOneElementFrom(_ otherArray: [Element]) -> Bool {
        for element in otherArray {
            if self.contains(element) {
                return true
            }
        }
        return false
    }
}
