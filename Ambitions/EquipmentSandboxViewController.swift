//
//  EquipmentSandboxViewController.swift
//  Ambitions
//
//  Created by Clément on 14/03/2018.
//  Copyright © 2018 Clément. All rights reserved.
//

import UIKit

class EquipmentSandboxViewController: UIViewController,
UITableViewDelegate, UITableViewDataSource, UIDragInteractionDelegate, UIDropInteractionDelegate {
    
    // MARK: - Properties
    
    private var characters: [Card] {
        return Collection().cards.filter{$0.cardType == Card.CardType.hero
                                        || $0.cardType == Card.CardType.ally}
    }
    
    private var equipments: [Card] {
        return Collection().cards.filter{$0.cardType == Card.CardType.equipment
                                        || $0.cardType == Card.CardType.ability}
    }
    
    private var currentCharacterCard: CharacterCard?
    private var currentEquipmentCard: Card?
    
    // MARK: - Outlets
    
    @IBOutlet weak var charactersTableView: UITableView! {
        didSet {
            charactersTableView.dataSource = self
            charactersTableView.delegate = self
        }
    }
    @IBOutlet weak var characterCardView: CardView! {
        didSet {
            if let card = characters.first as? CharacterCard {
                currentCharacterCard = card
                characterCardView.configureWith(card)
            }
        }
    }
    
    @IBOutlet weak var equipmentsTableView: UITableView!{
        didSet {
            equipmentsTableView.dataSource = self
            equipmentsTableView.delegate = self
        }
    }
    @IBOutlet weak var equipmentCardView: CardView! {
        didSet {
            if let card = equipments.first {
                currentEquipmentCard = card
                equipmentCardView.configureWith(card)
            }
        }
    }
    
    // MARK: - TableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == charactersTableView {
            return characters.count
        } else if tableView == equipmentsTableView {
            return equipments.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as? CardTableViewCell
        
        // Configure the cell...
        var card: Card? = nil
        if tableView == charactersTableView {
            card = characters[indexPath.row]
        } else if tableView == equipmentsTableView {
            card = equipments[indexPath.row]
        }
        
        cell?.configureWith(card)
        
        if let cardType = card?.cardType  {
            cell?.layer.cornerRadius = 5.0
            cell?.clipsToBounds = true
            cell?.layer.borderWidth = 5.0
            cell?.layer.borderColor = cardType.getCardColor().cgColor
        }
        
        return cell!
    }
    
    // MARK: - TableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == charactersTableView {
            if let card = characters[indexPath.row] as? CharacterCard {
                currentCharacterCard = card
                characterCardView.configureWith(card)
            }
            
        } else if tableView == equipmentsTableView {
            let card = equipments[indexPath.row]
            currentEquipmentCard = card
            equipmentCardView.configureWith(card)
            
        } 
    }
    
    // MARK: - DragInteractionDelegate
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        if let card = currentEquipmentCard {
            let dragItem = UIDragItem(itemProvider: NSItemProvider(object: card.fullName as NSItemProviderWriting))
            dragItem.localObject = card
            return [dragItem]
        } else {
            return []
        }
    }
    
    // MARK: - DropInterractionDelegate
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        if let item = session.items.first, let card = item.localObject as? Card {
            return currentCharacterCard!.canEquip(card) ? session.canLoadObjects(ofClass: NSString.self) : false
        }
        return false
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        for item in session.items {
            if let card = item.localObject as? Card {
                currentCharacterCard?.equipWith(card)
                characterCardView.configureWith(currentCharacterCard!)
            }
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        characterCardView.addInteraction(UIDropInteraction(delegate: self))
        equipmentCardView.addInteraction(UIDragInteraction(delegate: self))
    }

}
