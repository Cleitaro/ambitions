//
//  CardView.swift
//  Ambitions
//
//  Created by Clément on 16/02/2018.
//  Copyright © 2018 Clément. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    //MARK: - CardView properties
    var name: String = "" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    var fullName: String = ""  { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    var abilities: String = ""  { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    var type: String = ""  { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    var cardColor: UIColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)  { didSet { setNeedsDisplay(); setNeedsLayout() } }

    var lifePoint: Int? = nil  { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    var resistance: Int? = nil  { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    var attack: Int? = nil  { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    var firstAfinity: String?  { didSet {
        firstAfinityHex.removeFromSuperview()
        firstAfinityHex = createHexImageViewWith(name: firstAfinity)
        setNeedsDisplay()
        setNeedsLayout()
        }
    }
    var secondAfinity: String?  { didSet {
        secondAfinityHex.removeFromSuperview()
        secondAfinityHex = createHexImageViewWith(name: secondAfinity)
        setNeedsDisplay()
        setNeedsLayout()
        }
    }
    
    var isFaceUp : Bool = true  { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    // MARK: - Configuration Method
    
    func configureWith(_ card: Card) {
        name = card.name
        fullName = card.fullName
        if let characterCard = card as? CharacterCard {
            lifePoint = characterCard.lifePoint
            resistance = characterCard.resistance
            attack = characterCard.attack
        }
        cardColor = card.cardType.getCardColor()
        abilities = ""
        for capability in card.capabilities {
            abilities.append("\n\(capability.text)")
        }
        if card.capabilities.count > 0 {
            abilities.append("\n")
        }
        firstAfinity = card.firstAfinity?.rawValue
        secondAfinity = card.secondAfinity?.rawValue
    }
    
    // MARK: - Handle CardView scaling
    
    var faceCardScale: CGFloat = SizeRatio.faceCardImageSizeToBoundsSize { didSet { setNeedsDisplay() } }
    
    var cardScale: CGFloat = 1.0
    
    @objc func adjustCardScale(byHandlingGestureRecognizerBy recognizer: UIPinchGestureRecognizer) {
        switch  recognizer.state {
        case .changed, .ended:
            cardScale *= recognizer.scale
            self.transform = CGAffineTransform.init(scaleX: cardScale, y: cardScale)
            recognizer.scale = 1.0
        default:
            break
        }
    }
    
    //Mark: - CardView Labels
    
    private var lifePointString : NSAttributedString? {
        if let lp = lifePoint {
            return centeredAttributedString(String(lp),
                                            fontSize: fontSize)
        } else {
            return nil
        }
    }
    
    private var resitanceString : NSAttributedString? {
        if let res = resistance {
            return centeredAttributedString(String(res),
                                            fontSize: fontSize)
        } else {
            return nil
        }
    }
    
    private var attackString : NSAttributedString? {
        if let atck = attack {
            return centeredAttributedString(String(atck),
                                            fontSize: fontSize)
        } else {
            return nil
        }
    }
    
    private var fullNameString : NSAttributedString {
        return centeredAttributedString(fullName,
                                        fontSize: fontSize / 2)
    }
    
    private var abilitiesString : NSAttributedString {
        return centeredAttributedString(abilities,
                                        fontSize: fontSize / 2)
    }
    
    private lazy var lifePointLabel = createLabel()
    private lazy var resistanceLabel = createLabel()
    private lazy var attackLabel = createLabel()
    
    private lazy var fullNameLabel = createLabel()
    
    private lazy var abilitiesLabel = createLabel()
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        addSubview(label)
        return label
    }
    
    private func configureLabel(_ label: UILabel, attributedString: NSAttributedString) {
        label.attributedText = attributedString
        label.backgroundColor = self.cardColor
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.isHidden = !isFaceUp
    }
    
    private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [.paragraphStyle:paragraphStyle ,
                                                               .font:font])
    }
    
    //Needed mainly for accessibility purposes in order to keep things clean when app is reopenned after fontSize was changed from Settings
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    //MARK: - CardView Images
    private lazy var firstAfinityHex = createHexImageViewWith(name: firstAfinity)
    private lazy var secondAfinityHex = createHexImageViewWith(name: secondAfinity)
    
    //MARK - CardView drawing
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        //FullName Label on top left, one line
        fullNameLabel.frame.size = CGSize(width: bounds.size.width,
                                          height: 24)
        configureLabel(fullNameLabel, attributedString: fullNameString)
        fullNameLabel.frame.origin = bounds.origin.offsetBy(dx: 0,
                                                            dy: 0)
        
        //LifePoint + Resistance + Attack Labels under FullName Label going down on the right side
        if let lpString = lifePointString {
            lifePointLabel.isHidden = false
            lifePointLabel.frame.size = CGSize(width: 34,
                                               height: 24)
            configureLabel(lifePointLabel, attributedString: lpString)
            lifePointLabel.frame.origin = bounds.origin.offsetBy(
                dx: bounds.size.width - lifePointLabel.frame.size.width,
                dy: fullNameLabel.frame.size.height)
        } else {
            lifePointLabel.isHidden = true
        }
        
        if let resString = resitanceString {
            resistanceLabel.isHidden = false
            resistanceLabel.frame.size = CGSize(width: 34,
                                                height: 24)
            configureLabel(resistanceLabel, attributedString: resString)
            resistanceLabel.frame.origin = bounds.origin.offsetBy(
                dx: bounds.size.width - resistanceLabel.frame.size.width,
                dy: fullNameLabel.frame.size.height + lifePointLabel.frame.size.height)
        } else {
            resistanceLabel.isHidden = true
        }
        
        if let atckString = attackString {
            attackLabel.isHidden = false
            attackLabel.frame.size = CGSize(width: 34,
                                            height: 24)
            configureLabel(attackLabel, attributedString: atckString)
            attackLabel.frame.origin = bounds.origin.offsetBy(
                dx: bounds.size.width - attackLabel.frame.size.width,
                dy: fullNameLabel.frame.size.height
                    + lifePointLabel.frame.size.height
                    + resistanceLabel.frame.size.height)
        } else {
            attackLabel.isHidden = true
        }
        
        // Abilities Label Centered
        abilitiesLabel.frame.size = CGSize(width: bounds.size.width - offset * 2,
                                          height: 0)
        configureLabel(abilitiesLabel, attributedString: abilitiesString)
        abilitiesLabel.sizeToFit()
        abilitiesLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        abilitiesLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        abilitiesLabel.center = CGPoint(x: bounds.size.width/2, y: bounds.size.height/2)
        
        // Afinities
        firstAfinityHex.frame.origin = bounds.origin.offsetBy(dx: offset,
                                                              dy: bounds.maxY - firstAfinityHex.frame.size.height * 2)
        firstAfinityHex.isHidden = !isFaceUp
        secondAfinityHex.frame.origin = bounds.origin.offsetBy(dx: offset + secondAfinityHex.frame.size.height * 0.5,
                                                              dy: bounds.maxY - secondAfinityHex.frame.size.height * 1.2)
        secondAfinityHex.isHidden = !isFaceUp
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.borderWidth = 5.0
        self.layer.borderColor = self.cardColor.cgColor
        
        if isFaceUp {
            if let cardImage = UIImage(named: name) {
                cardImage.draw(in: bounds.zoom(by: faceCardScale))
            }
        } else {
            #imageLiteral(resourceName: "cardback").draw(in: bounds)
        }
    }

}

// CardView extension for constants
extension CardView {
    private struct SizeRatio {
        static let fontSizeToBoundsHeight: CGFloat = 0.065
        static let radiusToBoundsHeight: CGFloat = 0.06
        static let offsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 1.0
    }
    
    private var radius: CGFloat {
        return bounds.size.height * SizeRatio.radiusToBoundsHeight
    }
    
    private var offset: CGFloat {
        return radius * SizeRatio.offsetToCornerRadius
    }
    
    private var fontSize: CGFloat {
        return bounds.size.height * SizeRatio.fontSizeToBoundsHeight
    }
}

// CardView Extension

extension CardView {
    
    func createHexImageViewWith(name: String?) -> UIImageView {
        let hexImageView = UIImageView()
        
        if let imageName = name {
            hexImageView.image = UIImage(named: imageName)
            hexImageView.frame.size = CGSize(width: 50, height: 50)
            hexImageView.contentMode = UIViewContentMode.scaleAspectFit
            setupHexagonImageView(imageView: hexImageView)
            addSubview(hexImageView)
        }
        return hexImageView
    }
}

// UIView Extension for hex drawing

extension UIView {
    
    func roundedPolygonPath(rect: CGRect, lineWidth: CGFloat, sides: NSInteger, cornerRadius: CGFloat, rotationOffset: CGFloat = 0)
        -> UIBezierPath {
            let path = UIBezierPath()
            let theta: CGFloat = CGFloat(2.0 * CGFloat.pi) / CGFloat(sides) // How much to turn at every corner
            let width = min(rect.size.width, rect.size.height)        // Width of the square
            
            let center = CGPoint(x: rect.origin.x + width / 2.0, y: rect.origin.y + width / 2.0)
            
            // Radius of the circle that encircles the polygon
            // Notice that the radius is adjusted for the corners, that way the largest outer
            // dimension of the resulting shape is always exactly the width - linewidth
            let radius = (width - lineWidth + cornerRadius - (cos(theta) * cornerRadius)) / 2.0
            
            // Start drawing at a point, which by default is at the right hand edge
            // but can be offset
            var angle = CGFloat(rotationOffset)
            
            let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle),
                                 y: center.y + (radius - cornerRadius) * sin(angle))
            path.move(to: CGPoint(x: corner.x + cornerRadius * cos(angle + theta),
                                  y: corner.y + cornerRadius * sin(angle + theta)))
            
            for _ in 0 ..< sides {
                angle += theta
                
                let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle),
                                     y: center.y + (radius - cornerRadius) * sin(angle))
                let tip = CGPoint(x: center.x + radius * cos(angle),
                                  y: center.y + radius * sin(angle))
                let start = CGPoint(x: corner.x + cornerRadius * cos(angle - theta),
                                    y: corner.y + cornerRadius * sin(angle - theta))
                let end = CGPoint(x: corner.x + cornerRadius * cos(angle + theta),
                                  y: corner.y + cornerRadius * sin(angle + theta))
                
                path.addLine(to: start)
                path.addQuadCurve(to: end, controlPoint: tip)
            }
            
            path.close()
            
            // Move the path to the correct origins
            let bounds = path.bounds
            let transform = CGAffineTransform(translationX: -bounds.origin.x + rect.origin.x + lineWidth / 2.0,
                                              y: -bounds.origin.y + rect.origin.y + lineWidth / 2.0)
            path.apply(transform)
            
            return path
    }
    
    func setupHexagonImageView(imageView: UIImageView) {
        let lineWidth: CGFloat = 5
        let path = roundedPolygonPath(rect: imageView.bounds,
                                      lineWidth: lineWidth,
                                      sides: 6,
                                      cornerRadius: 5,
                                      rotationOffset: CGFloat(CGFloat.pi / 2.0))
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.lineWidth = lineWidth
        mask.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        mask.fillColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        imageView.layer.mask = mask
        
        let border = CAShapeLayer()
        border.path = path.cgPath
        border.lineWidth = lineWidth
        border.strokeColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        border.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        imageView.layer.addSublayer(border)
    }
}
