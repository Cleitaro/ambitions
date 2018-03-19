//
//  Collection.swift
//  Ambitions
//
//  Created by Clément on 23/02/2018.
//  Copyright © 2018 Clément. All rights reserved.
//

import Foundation

struct Collection {
    
    var cards = [Card]()
    
    init() {
        // Add Letho
        let lethoCard = CharacterCard(fullName: "Letho, Seigneur de la nuit",
                             name: "letho",
                             maxLifePoint: 15,
                             resistance: 2,
                             attack: 5,
                             cardType: Card.CardType.hero,
                             capabilities: [Capability(text: "Vampirisme"), Capability(text: "Quand letho tue un allié adverse, invoquez une Ghoul sur une case adjacente.")],
                             shapes: [Card.Shape.beast],
                             firstAfinity: Card.Afinities.darkness,
                             secondAfinity: Card.Afinities.savage)
        cards.append(lethoCard)
        
        // Add Nicolas
        let nicholasCard = CharacterCard(fullName: "Nicholas Pétrov, Nanoprêtre",
                                name: "nicholas",
                                maxLifePoint: 12,
                                resistance: 1,
                                attack: 3,
                                cardType: Card.CardType.hero,
                                capabilities: [Capability(text: "Nicholas peut utiliser une action pour poser un implant neural du réseau sur un allié adjacent. Il peut aussi choisir d'en poser un lorsqu'il attaque un adversaire, il n'inflige alors aucun dégât.")],
                                shapes: [Card.Shape.human],
                                firstAfinity: Card.Afinities.technology,
                                secondAfinity: Card.Afinities.faith)
        cards.append(nicholasCard)
        
        //Ambitions Cards
        let ennemy = Card(fullName: "Ennemi juré", name: "ennemy", cardType: Card.CardType.ambition,
                          capabilities: [Capability(text: "Tuer le personnage adverse")],
                          shapes: [])
        cards.append(ennemy)
        
        let soulmate = Card(fullName: "Âme soeur démoniaque", name: "soulmate", cardType: Card.CardType.ambition,
                            capabilities: [Capability(text: "Un de vos alliés partageant un type avec votre personnage doit tuer 4 alliés adverses")],
                            shapes: [],
                            firstAfinity: Card.Afinities.darkness)
        cards.append(soulmate)
        
        let sins = Card(fullName: "Rachat des pêchés", name: "sins", cardType: Card.CardType.ambition,
                        capabilities: [Capability(text: "Lorsque votre personnage donne un coup mortel a un allié ou personnage adverse, il peut choisir de lui donner 4 points de vie à la place. Donner 12 points de vie de cette façon.")],
                        shapes: [],
                        firstAfinity: Card.Afinities.darkness)
        cards.append(sins)
        
        let slaughter = Card(fullName: "Boucherie", name: "slaughter", cardType: Card.CardType.ambition,
                             capabilities: [Capability(text: "Infliger 40 points de dégâts avec votre personnage.")],
                             shapes: [],
                             firstAfinity: Card.Afinities.savage)
        cards.append(slaughter)
        
        //Allies Cards
        let constantina = CharacterCard(fullName: "Constantina O'Hara", name: "constantina",
                               maxLifePoint: 5, resistance: 0, attack: 3, cardType: Card.CardType.ally,
                               capabilities: [Capability(text: "Quand Constantina entre en jeu, vous pouvez aller chercher une carte de Grigri dans votre deck ou votre passé et l'équiper avec.")],
                               shapes: [Card.Shape.human],
                               firstAfinity: Card.Afinities.darkness)
        cards.append(constantina)
        
        let dena = CharacterCard(fullName: "Dena, victime consentante", name: "dena",
                        maxLifePoint: 5, resistance: 0, attack: 1, cardType: Card.CardType.ally,
                        capabilities: [Capability(text: "Si Dena est adjacente a un personnage allié avec l'affinité Ténèbres, elle peut utiliser une action pour lui donner 3 de ses points de vie. Si Dena meurt de cette façon, retirez là de la partie et remplacez là par une ghoul. Elle conserve son nom.")],
                        shapes: [Card.Shape.human])
        cards.append(dena)
        
        let ghoul = CharacterCard(fullName: "Ghoul", name: "ghoul",
                         maxLifePoint: 5, resistance: 0, attack: 2, cardType: Card.CardType.ally,
                         capabilities: [Capability(text: "Si la Ghoul tue une cible et survie, retirez là de la partie et remplacez là par un Vampire novice")],
                         shapes: [Card.Shape.human, Card.Shape.beast],
                         firstAfinity: Card.Afinities.savage)
        cards.append(ghoul)
        
        let vampire = CharacterCard(fullName: "Vampire novice", name: "vampire",
                           maxLifePoint: 8, resistance: 1, attack: 3, cardType: Card.CardType.ally,
                           capabilities: [Capability(text: "Vampirisme")],
                           shapes: [Card.Shape.human],
                           firstAfinity: Card.Afinities.savage,
                           secondAfinity: Card.Afinities.darkness)
        cards.append(vampire)
        
        let derebron = CharacterCard(fullName: "Dérébron, étrangeté de compagnie", name: "derebron",
                           maxLifePoint: 1, resistance: 1, attack: 1, cardType: Card.CardType.ally,
                           capabilities: [],
                           shapes: [Card.Shape.beast],
                           firstAfinity: Card.Afinities.savage)
        cards.append(derebron)
        
        let tos = CharacterCard(fullName: "Tos, entité sauvage", name: "tos",
                            maxLifePoint: 1, resistance: 1, attack: 1, cardType: Card.CardType.ally,
                            capabilities: [],
                            shapes: [Card.Shape.elemental],
                            firstAfinity: Card.Afinities.savage)
        cards.append(tos)
        
        let lith = CharacterCard(fullName: "Lith, adepte de la souffrance", name: "lith",
                       maxLifePoint: 1, resistance: 1, attack: 1, cardType: Card.CardType.ally,
                       capabilities: [Capability(text: "Lith gagne +1 résistance à chaque fois qu'elle perd de la vie.")],
                       shapes: [Card.Shape.human],
                       firstAfinity: Card.Afinities.savage)
        cards.append(lith)
        
        // Equipments
        
        let necronomicon = Card(fullName: "Nécronomicon", name: "necronomicon",cardType: Card.CardType.equipment,
                                capabilities: [Capability(text: "Choisissez un allié dans le passé. Le porteur du Nécronomicon peut payer le double du total de point de vie de la cible pour l'invoquer sur une case adjacente. Rendez-lui la moitié de ses points de vie arrondi au supérieur.")],
                                shapes: [Card.Shape.human, Card.Shape.elemental],
                                firstAfinity: Card.Afinities.darkness,
                                isUnique: true)
        cards.append(necronomicon)

        let duel_sword = Card(fullName: "Epée de duel", name: "duel_sword",cardType: Card.CardType.equipment,
                              capabilities: [Capability(text: "+3 attaque", statChangeKind: Card.CardStatKind.attack, statChangeValue: 3),Capability(text: "+1 résistance", statChangeKind: Card.CardStatKind.resistance, statChangeValue: 1)],
                              shapes: [Card.Shape.human])
        cards.append(duel_sword)
        
        let dragon_bone = Card(fullName: "Mâchoire d'os de dragon", name: "dragon_bone",cardType: Card.CardType.equipment,
                               capabilities: [Capability(text: "+5 attaque", statChangeKind: Card.CardStatKind.attack, statChangeValue: 5), Capability(text: "+2 résistance", statChangeKind: Card.CardStatKind.resistance, statChangeValue: 2)],
                               shapes: [Card.Shape.beast],
                               firstAfinity: Card.Afinities.savage)
        cards.append(dragon_bone)
        
        let night_cape = Card(fullName: "Cape de la nuit", name: "night_cape",cardType: Card.CardType.equipment,
                              capabilities: [Capability(text: "Vous êtes immunisé aux malus des localisations adverses.")],
                              shapes: [Card.Shape.human],
                              firstAfinity: Card.Afinities.darkness)
        cards.append(night_cape)
        
        let liaison_stone = Card(fullName: "Pierre de liaison", name: "liaison_stone",cardType: Card.CardType.equipment,
                                 capabilities: [Capability(text: "+2 attaque", statChangeKind: Card.CardStatKind.attack, statChangeValue: 2),Capability(text: "+2 résistance", statChangeKind: Card.CardStatKind.resistance, statChangeValue: 2)],
                                 shapes: [Card.Shape.elemental])
        cards.append(liaison_stone)
        
        let provision = Card(fullName: "Provision", name: "provision",cardType: Card.CardType.equipment,
                             capabilities: [Capability(text: "Rend 3 points de vie. Utilisable 2 fois avant d'être retiré de la partie. N'utiliser cette capacité que si le porteur ou la cible n'est pas engager en combat.")],
                             shapes: [])
        cards.append(provision)
        
        let darkness_horse = Card(fullName: "Destrier de l'effroi", name: "darkness_horse",cardType: Card.CardType.equipment,
                                  capabilities: [Capability(text: "+1 attaque", statChangeKind: Card.CardStatKind.attack, statChangeValue: 1),Capability(text: "+1 résistance", statChangeKind: Card.CardStatKind.resistance, statChangeValue: 1),Capability(text: "+1 mouvement"),Capability(text: "Votre allié ou personnage peut monter au descendre du destrier. Ils restent sur la même ligne pour le tour. Le destrier devient un allié.")],
                                  shapes: [Card.Shape.human])
        cards.append(darkness_horse)
        
        let kraken_mark = Card(fullName: "Marque du Kraken", name: "kraken_mark",cardType: Card.CardType.equipment,
                               capabilities: [Capability(text: "-2 vie", statChangeKind: Card.CardStatKind.life, statChangeValue: -2), Capability(text: " +1 action"), Capability(text: " +1 attaque", statChangeKind: Card.CardStatKind.attack, statChangeValue: 1), Capability(text: "Un personnage/allié ne peut porter qu'une seule fois la même marque.")],
                               shapes: [Card.Shape.human, Card.Shape.beast],
                               firstAfinity: Card.Afinities.savage)
        cards.append(kraken_mark)
        
        let deflection_grigri = Card(fullName: "Grigri de déflection", name: "deflection_grigri",cardType: Card.CardType.equipment,
                                     capabilities: [Capability(text: "-1 vie", statChangeKind: Card.CardStatKind.life, statChangeValue: -1),Capability(text: "Envoyer le fétiche au passé pour annuler la première source de dégâts de n'importe quel type ou compétence qui cible le porteur. Un personnage/allié ne peut porter qu'une seule fois le même Grigri.")],
                                     shapes: [Card.Shape.human, Card.Shape.beast],
                                     firstAfinity: Card.Afinities.darkness)
        cards.append(deflection_grigri)
        
        let fresh_meat = Card(fullName: "Carcasse fraîche", name: "fresh_meat",cardType: Card.CardType.equipment,
                              capabilities: [Capability(text: "Retirer la carcasse de la partie pour regagner 6 points de vie. N'utiliser cette capacité que si le porteur ou la cible n'est pas engagé en combat.")],
                              shapes: [Card.Shape.beast],
                              firstAfinity: Card.Afinities.savage)
        cards.append(fresh_meat)
        
        // Abilities
        let dead_dance = Card(fullName: "Danse des morts", name: "dead_dance",cardType: Card.CardType.ability,
                              capabilities: [Capability(text: "Sacrifier 2 points de vie et une carte allié humanoïde, bestial ou une carcasse fraîche dans votre passé. Invoquez un mort-vivant du même type sur une case adjacente.")],
                              shapes: [],
                              firstAfinity: Card.Afinities.darkness)
        cards.append(dead_dance)
        
        let blinded_charge = Card(fullName: "Charge aveugle", name: "blinded_charge",cardType: Card.CardType.ability,
                                  capabilities: [Capability(text: "Avancer de 2 lignes, toutes les unités que vous traversez subissent 2 points de dégâts physiques.")],
                                  shapes: [],
                                  firstAfinity: Card.Afinities.savage)
        cards.append(blinded_charge)
        
        let darkness_charm = Card(fullName: "Charmé par les ténèbres", name: "darkness_charm",cardType: Card.CardType.ability,
                                  capabilities: [Capability(text: "Un allié adverse gagne -2 attaque et -2 résistance jusqu'à la fin de votre tour.")],
                                  shapes: [],
                                  firstAfinity: Card.Afinities.darkness)
        cards.append(darkness_charm)
        
        let in_shadow = Card(fullName: "Dans les ombres", name: "in_shadow",cardType: Card.CardType.ability,
                             capabilities: [Capability(text: "Déplacer le personnage/allié ciblé d'une ligne. Il gagne +2 résistance tant qu'il ne fait pas de nouvelle action.")],
                             shapes: [],
                             firstAfinity: Card.Afinities.darkness)
        cards.append(in_shadow)
        
        let blood_ritual = Card(fullName: "Rituel du sang", name: "blood_ritual",cardType: Card.CardType.ability,
                                capabilities: [Capability(text: "Sacrifier 3 points de vie. Récupérez une carte de votre passé. Vous ne pouvez pas récupérer une carte Unique face visible.")],
                                shapes: [],
                                firstAfinity: Card.Afinities.darkness, isUnique: true)
        cards.append(blood_ritual)
        
        let savage_bite = Card(fullName: "Morsure sauvage", name: "savage_bite",cardType: Card.CardType.ability,
                               capabilities: [Capability(text: "Infligez 4 points de dégâts à un personnage/allié adverse sur votre ligne. Cette action initie un combat si cela n'était pas encore le cas.")],
                               shapes: [],
                               firstAfinity: Card.Afinities.savage)
        cards.append(savage_bite)
        
        let see_abyss = Card(fullName: "Contempler les abysses", name: "see_abyss",cardType: Card.CardType.ability,
                             capabilities: [Capability(text: "L'adversaire ne peut pas piocher de compétence à son prochain tour.")],
                             shapes: [],
                             firstAfinity: Card.Afinities.darkness, isUnique: true)
        cards.append(see_abyss)
        
        let cap_change = Card(fullName: "Changement de cap", name: "cap_change",cardType: Card.CardType.ability,
                              capabilities: [Capability(text: "Echanger une de vos cartes ambitions avec une de votre passé. Leurs progressions sont réinitialisés")],
                              shapes: [],
                              isUnique: true)
        cards.append(cap_change)
        
        let tomb_raider = Card(fullName: "Pilleur de tombe", name: "tomb_raider",cardType: Card.CardType.ability,
                               capabilities: [Capability(text: "Choisissez : \n - Prenez un équipement dans le passé face visible adverse et équipez le si vous le pouvez.\n - Prenez un allié dans le passé face visible adverse et mettez le dans le votre.\n - Retirez de la partie une carte aléatoire face cachée du passé adverse.")],
                               shapes: [],
                               firstAfinity: Card.Afinities.darkness)
        cards.append(tomb_raider)
        
    }
    
    mutating func pick() -> Card! {
        if cards.count > 0 {
            return cards[cards.count.arc4random]
        } else {
            return nil
        }
    }
}
