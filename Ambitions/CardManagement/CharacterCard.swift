//
//  CharacterCard.swift
//  Ambitions
//
//  Created by Clément on 16/03/2018.
//  Copyright © 2018 Clément. All rights reserved.
//

import Foundation

class CharacterCard : Card {
    
    var lifePoint : Int
    var maxLifePoint : Int
    var resistance : Int
    var attack : Int
    
    private enum CodingKeys : String, CodingKey {
        case lifePoint
        case maxLifePoint
        case resistance
        case attack
    }
    
    init(fullName: String,
         name: String,
         maxLifePoint: Int,
         resistance: Int,
         attack: Int,
         cardType: CardType,
         capabilities : [Capability],
         shapes : [Shape],
         firstAfinity: Afinities? = nil,
         secondAfinity : Afinities? = nil,
         isUnique : Bool = false) {
        self.maxLifePoint = maxLifePoint
        self.lifePoint = maxLifePoint
        self.resistance = resistance
        self.attack = attack
        super.init(fullName: fullName,
                   name: name,
                   cardType: cardType,
                   capabilities: capabilities,
                   shapes: shapes,
                   firstAfinity: firstAfinity,
                   secondAfinity: secondAfinity,
                   isUnique: isUnique)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lifePoint = try container.decode(Int.self, forKey: .lifePoint)
        maxLifePoint = try container.decode(Int.self, forKey: .maxLifePoint)
        resistance = try container.decode(Int.self, forKey: .resistance)
        attack = try container.decode(Int.self, forKey: .attack)
        let superDecoder = try container.superDecoder()
        try super.init(from: superDecoder)
    }
    
    
    
    //MARK: - Change methods
    
    func equipWith(_ card: Card) {
        if( card.cardType == Card.CardType.equipment || card.cardType == Card.CardType.ability )
        {
            for capabilities in card.capabilities {
                if let statChangeKind =  capabilities.statChangeKind {
                    switch statChangeKind {
                    case .life:
                        self.lifePoint += capabilities.statChangeValue!
                    case .attack:
                        self.attack += capabilities.statChangeValue!
                    case .resistance:
                        self.resistance += capabilities.statChangeValue!
                    }
                }
            }
        }
    }
    
    func canEquip(_ card: Card) -> Bool {
        if( card.cardType == Card.CardType.equipment || card.cardType == Card.CardType.ability )
        {
            return (card.firstAfinity == nil || card.firstAfinity == self.firstAfinity || card.firstAfinity == self.secondAfinity) &&
                (card.shapes.count == 0 || card.shapes.containsAtLeastOneElementFrom(self.shapes) )
        } else {
            return false
        }
    }
    
}
