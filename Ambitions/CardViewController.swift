//
//  CardViewController.swift
//  Ambitions
//
//  Created by Clément on 16/02/2018.
//  Copyright © 2018 Clément. All rights reserved.
//

import UIKit

// Class that show a CardView using a Card model
class CardViewController: UIViewController {

    // MARK: - Model
    
    var collection = Collection()
    
    //MARK: - CardView handle
    
    // a cardView from IB that can be pinched to zoom and flipped
    @IBOutlet weak var cardView: CardView! {
        didSet {
            //Pinch Gesture
            let pinch = UIPinchGestureRecognizer(target: cardView, action: #selector(CardView.adjustCardScale(byHandlingGestureRecognizerBy:)))
            cardView.addGestureRecognizer(pinch)
            //Tap Gesture
            cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipCard(_:))))
            //Swipe Gesture
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            cardView.addGestureRecognizer(swipe)
        }
    }
    
    @objc private func nextCard() {
        if let card = collection.pick() {
            cardView.configureWith(card)
        }
    }
    
    // Function called when the cardView is tapped in order change its isFaceUp attribute and animate accordingly
    @objc private func flipCard(_ recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if let chosenCardView = recognizer.view as? CardView {
                UIView.transition(with: chosenCardView,
                                  duration: 0.6,
                                  options: [.transitionFlipFromLeft],
                                  animations: {chosenCardView.isFaceUp = !chosenCardView.isFaceUp}
                )
            }
        default:
            break
        }
    }
    
    //MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nextCard()
    }
}

