//
//  CardTableViewCell.swift
//  Ambitions
//
//  Created by Clément on 23/02/2018.
//  Copyright © 2018 Clément. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var cardAttributes: UILabel!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var firstAfinityHex: UIImageView!
    @IBOutlet weak var secondAfinityHex: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var firstAfinityWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondAfinityWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cardAttributesWidthConstraint: NSLayoutConstraint!
    // MARK: - Configuration
    
    func configureWith(_ card: Card?) {
        cardName?.text = card?.fullName
        if let characterCard = card as? CharacterCard {
            let lifePoint = characterCard.lifePoint
            let resistance = characterCard.resistance
            let attack = characterCard.attack
            cardAttributes?.text = "\(String(lifePoint)) - \(String(resistance)) - \(String(attack))"
            cardAttributesWidthConstraint.constant = 80
        } else {
            cardAttributes?.text = ""
            cardAttributesWidthConstraint.constant = 0
        }
        
        if let cardImage = UIImage(named: (card?.name)!) {
            backgroundImage.image = cardImage
        } else {
            backgroundImage.image = nil
        }
        
        if let cardFirstAfinity = card?.firstAfinity {
            firstAfinityWidthConstraint.constant = 38
            firstAfinityHex.image = UIImage(named: cardFirstAfinity.rawValue)
            firstAfinityHex.isHidden = false
            setupHexagonImageView(imageView: firstAfinityHex)
        } else {
            firstAfinityHex.image = nil
            firstAfinityHex.isHidden = true
            firstAfinityWidthConstraint.constant = 0
        }
        
        if let cardSecondAfinity = card?.secondAfinity {
            secondAfinityWidthConstraint.constant = 38
            secondAfinityHex.image = UIImage(named: cardSecondAfinity.rawValue)
            secondAfinityHex.isHidden = false
            setupHexagonImageView(imageView: secondAfinityHex)
        } else {
            secondAfinityHex.image = nil
            secondAfinityHex.isHidden = true
            secondAfinityWidthConstraint.constant = 0
        }
    }
}
