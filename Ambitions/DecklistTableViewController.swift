//
//  DecklistTableViewController.swift
//  Ambitions
//
//  Created by Clément on 22/02/2018.
//  Copyright © 2018 Clément. All rights reserved.
//

import UIKit

class DecklistTableViewController: UITableViewController, UIDropInteractionDelegate {

    // MARK: - Properties
    
    private var deck = Deck()
    
    // MARK: - Outlets
    
    @IBAction func saveCurrentDeck(_ sender: UIBarButtonItem) {
        
        if let json = deck.json {
            if let url = try? FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            ).appendingPathComponent("Untitled.json") {
                do {
                  try json.write(to: url)
                    print("Saved successfully")
                } catch let error {
                    print("Could not save \(error)")
                }
            }
            
        }
        
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Card.CardType.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            case Card.CardType.hero.sectionIndex :
                return deck.hero != nil ? 1 : 0
            case Card.CardType.ally.sectionIndex :
                return deck.allies.count
            case Card.CardType.equipment.sectionIndex :
                return deck.equipments.count
            case Card.CardType.ability.sectionIndex :
                return deck.abilities.count
            case Card.CardType.ambition.sectionIndex :
                return deck.ambitions.count
            default :
                return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case Card.CardType.hero.sectionIndex :
                return "\(Card.CardType.hero.rawValue) : \(deck.hero != nil ? 1 : 0)/1"
            case Card.CardType.ally.sectionIndex :
                return "\(Card.CardType.ally.rawValue) : \(deck.allies.count)/\(deck.maxAllies)"
            case Card.CardType.equipment.sectionIndex :
                return "\(Card.CardType.equipment.rawValue) : \(deck.equipments.count)/\(deck.maxEquipments)"
            case Card.CardType.ability.sectionIndex :
                return "\(Card.CardType.ability.rawValue) : \(deck.abilities.count)/\(deck.maxAbilities)"
            case Card.CardType.ambition.sectionIndex :
                return "\(Card.CardType.ambition.rawValue) : \(deck.ambitions.count)/\(deck.maxAmbitions)"
            default :
                return "Default"
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as? CardTableViewCell

        // Configure the cell...
        var card: Card? = nil
        switch indexPath.section {
            case Card.CardType.hero.sectionIndex :
                card = deck.hero!
            case Card.CardType.ally.sectionIndex :
                card = deck.allies[indexPath.row]
            case Card.CardType.equipment.sectionIndex :
                card = deck.equipments[indexPath.row]
            case Card.CardType.ability.sectionIndex :
                card = deck.abilities[indexPath.row]
            case Card.CardType.ambition.sectionIndex :
                card = deck.ambitions[indexPath.row]
            default :
                break
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

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            switch indexPath.section {
                case Card.CardType.hero.sectionIndex :
                    deck.hero = nil
                case Card.CardType.ally.sectionIndex :
                    deck.allies.remove(at: indexPath.row)
                case Card.CardType.equipment.sectionIndex :
                    deck.equipments.remove(at: indexPath.row)
                case Card.CardType.ability.sectionIndex :
                    deck.abilities.remove(at: indexPath.row)
                case Card.CardType.ambition.sectionIndex :
                    deck.ambitions.remove(at: indexPath.row)
                default :
                    break
            }
            updateDetailVC()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - DropInterractionDelegate
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        for item in session.items {
            if let card = item.localObject as? Card {
                deck.addCard(card)
                updateDetailVC()
                tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        tableView.addInteraction(UIDropInteraction(delegate: self))
        
        updateDetailVC()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ).appendingPathComponent("Untitled.json") {
            if let jsonData = try? Data(contentsOf: url) {
                deck = Deck(json: jsonData)!
            }
            
        }
    }
    
    func updateDetailVC() {
        if let splitViewController = self.splitViewController, (splitViewController.viewControllers.count > 1) {
            if let detailVC = splitViewController.viewControllers[1] as? CollectionViewController {
                detailVC.updateCollectionViewKnowingDeck(deck)
            }
        }
    }

}
