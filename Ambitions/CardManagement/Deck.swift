//
//  Deck.swift
//  Ambitions
//
//  Created by Clément on 19/02/2018.
//  Copyright © 2018 Clément. All rights reserved.
//

import Foundation

struct Deck : Codable {
    
    var hero : Card?
    var allies = [Card]()
    var maxAllies = 5
    var ambitions = [Card]()
    var maxAmbitions = 5
    var equipments = [Card]()
    var maxEquipments = 15
    var maxCopiesOfEquipments = 2
    var abilities = [Card]()
    var maxAbilities = 20
    var maxCopiesOfAbilities = 3
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init?(json: Data) {
        if let newValue = try? JSONDecoder().decode(Deck.self, from: json){
            self = newValue
        }
        else {
            return nil
        }
    }
    
    init() {
        // Add Letho
        /*let lethoCard = Card(fullName: "Letho, Seigneur de la nuit",
                             name: "letho",
                             maxLifePoint: 15,
                             resistance: 2,
                             attack: 5,
                             cardType: Card.CardType.hero,
                             capabilities: [Capability(text: "Vampirisme"), Capability(text: "Quand letho tue un allié adverse, invoquez une Ghoul sur une case adjacente.")],
                             firstAfinity: Card.Afinities.darkness,
                             secondAfinity: Card.Afinities.savage)
        hero = lethoCard
        
        //Ambitions Cards
        let ennemy = Card(fullName: "Ennemi juré", name: "ennemy", cardType: Card.CardType.ambition,
                          capabilities: [Capability(text: "Tuer le personnage adverse")])
        ambitions.append(ennemy)
        
        let soulmate = Card(fullName: "Âme soeur démoniaque", name: "soulmate", cardType: Card.CardType.ambition,
                            capabilities: [Capability(text: "Un de vos alliés partageant un type avec votre personnage doit tuer 4 alliés adverses")],
                            firstAfinity: Card.Afinities.darkness)
        ambitions.append(soulmate)
        
        let sins = Card(fullName: "Rachat des pêchés", name: "sins", cardType: Card.CardType.ambition,
                        capabilities: [Capability(text: "Lorsque votre personnage donne un coup mortel a un allié ou personnage adverse, il peut choisir de lui donner 4 points de vie à la place. Donner 12 points de vie de cette façon.")],
                        firstAfinity: Card.Afinities.darkness)
        ambitions.append(sins)
        
        let slaughter = Card(fullName: "Boucherie", name: "slaughter", cardType: Card.CardType.ambition,
                             capabilities: [Capability(text: "Infliger 40 points de dégâts avec votre personnage.")],
                             firstAfinity: Card.Afinities.savage)
        ambitions.append(slaughter)
        
        //Allies Cards
        let constantina = Card(fullName: "Constantina O'Hara", name: "constantina",
                               maxLifePoint: 5, resistance: 0, attack: 3, cardType: Card.CardType.ally,
                               capabilities: [Capability(text: "Quand Constantina entre en jeu, vous pouvez aller chercher une carte de Grigri dans votre deck ou votre passé et l'équiper avec.")],
                               firstAfinity: Card.Afinities.darkness)
        allies.append(constantina)
        
        let dena = Card(fullName: "Dena, victime consentante", name: "dena",
                        maxLifePoint: 5, resistance: 0, attack: 1, cardType: Card.CardType.ally,
                        capabilities: [Capability(text: "Si Dena est adjacente a un personnage allié avec l'affinité Ténèbres, elle peut utiliser une action pour lui donner 3 de ses points de vie. Si Dena meurt de cette façon, retirez là de la partie et remplacez là par une ghoul. Elle conserve son nom.")])
        allies.append(dena)
        
        let ghoul = Card(fullName: "Ghoul", name: "ghoul",
                         maxLifePoint: 5, resistance: 0, attack: 2, cardType: Card.CardType.ally,
                         capabilities: [Capability(text: "Si la Ghoul tue une cible et survie, retirez là de la partie et remplacez là par un Vampire novice")], firstAfinity: Card.Afinities.savage)
        allies.append(ghoul)
        
        let vampire = Card(fullName: "Vampire novice", name: "vampire",
                           maxLifePoint: 8, resistance: 1, attack: 3, cardType: Card.CardType.ally,
                           capabilities: [Capability(text: "Vampirisme")], firstAfinity: Card.Afinities.savage, secondAfinity: Card.Afinities.darkness)
        allies.append(vampire)*/
        
    }
    
     mutating func addCard(_ card: Card) {
        //TODO : handle deck constraints here AND/OR in collectionViewController
        switch card.cardType {
            case .hero:
                hero = card
            case .ally:
                allies.append(card)
            case .ambition:
                ambitions.append(card)
            case .ability:
                abilities.append(card)
            case .equipment:
                equipments.append(card)
        }
    }
}
