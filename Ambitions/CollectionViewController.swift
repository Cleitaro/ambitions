//
//  CollectionViewController.swift
//  Ambitions
//
//  Created by Clément on 22/02/2018.
//  Copyright © 2018 Clément. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate {
    
    // MARK: - Properties
    
    private var collection = Collection()
    
    // MARK: - UICollectionViewDropDelegate
    
    /*func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        for item in coordinator.items {
            if let sourceIndexPath = item.sourceIndexPath {
                if let card = item.dragItem.localObject as? Card {
                    collectionView.performBatchUpdates({
                            collection.cards.remove(at: sourceIndexPath.item)
                            collection.cards.insert(card, at: destinationIndexPath.item)
                            collectionView.deleteItems(at: [sourceIndexPath])
                            collectionView.insertItems(at: [destinationIndexPath])
                        })
                    coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
                }
            }
        }
    }*/
    
    // MARK: - UICollectionViewDragDelegate
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return dragItems(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        return dragItems(at: indexPath)
    }
    
    private func dragItems(at indexPath: IndexPath) -> [UIDragItem] {
        let card = collection.cards[indexPath.row]
        if card.enabledInCollection {
            let dragItem = UIDragItem(itemProvider: NSItemProvider(object: card.fullName as NSItemProviderWriting))
            dragItem.localObject = card
            return [dragItem]
        } else {
            return []
        }
    }
    
    // MARK: - UICollectionViewDataSource Protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
        if let cardCell = cell as? CardCollectionViewCell {
            let card = collection.cards[indexPath.row]
            cardCell.cardView.configureWith(card)
            
            let cardScale : CGFloat = card.enabledInCollection ? 1.0 : 0.9
            cardCell.cardView.transform = CGAffineTransform.init(scaleX: cardScale, y: cardScale)
            cardCell.backgroundColor = card.enabledInCollection ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5944652289)
        }
        return cell
    }
    
    func updateCollectionViewKnowingDeck(_ deck : Deck) {
        for card in collection.cards {
            switch card.cardType {
                case Card.CardType.hero:
                    card.enabledInCollection = deck.hero == nil
                case Card.CardType.ally :
                    card.enabledInCollection = deck.allies.count < deck.maxAllies
                                                && !deck.allies.contains(card)
                case Card.CardType.equipment :
                    card.enabledInCollection = deck.equipments.count < deck.maxEquipments
                                                && deck.equipments.filter{$0 == card}.count
                                                    < deck.maxCopiesOfEquipments
                case Card.CardType.ability :
                    card.enabledInCollection = deck.abilities.count < deck.maxAbilities
                                                && deck.abilities.filter{$0 == card}.count
                                                    < deck.maxCopiesOfAbilities
                case Card.CardType.ambition :
                    card.enabledInCollection = deck.ambitions.count < deck.maxAmbitions
                                                && !deck.ambitions.contains(card)
            }
        }
        self.cardCollectionView.reloadData()
    }

    // MARK: - Outlets
    
    @IBOutlet weak var cardCollectionView: UICollectionView! {
        didSet {
            cardCollectionView.dataSource = self
            cardCollectionView.delegate = self
            cardCollectionView.dragDelegate = self
        }
    }

}
