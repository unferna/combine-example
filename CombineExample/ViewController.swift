//
//  ViewController.swift
//  CombineExample
//
//  Created by Carlos Vertel on 6/12/19.
//  Copyright © 2019 Fernando Florez. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var colorBoard: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let redPublishier = NotificationCenter.Publisher(center: .default, name: .redChanged, object: nil).map { notification -> UIColor? in notification.object as? UIColor }
        let greenPublishier = NotificationCenter.Publisher(center: .default, name: .greenChanged, object: nil).map { notification -> UIColor? in notification.object as? UIColor }
        let bluePublishier = NotificationCenter.Publisher(center: .default, name: .blueChanged, object: nil).map { notification -> UIColor? in notification.object as? UIColor }
        
        let colorBoardSubscriber = Subscribers.Assign(object: self.colorBoard, keyPath: \.backgroundColor)
        redPublishier.subscribe(colorBoardSubscriber)
        greenPublishier.subscribe(colorBoardSubscriber)
        bluePublishier.subscribe(colorBoardSubscriber)
    }
    
    @IBAction func redChanged(_ sender: UISlider) {
        let redCgFloat = CGFloat( sender.value )
        let greenCgFloat = CGFloat( self.greenSlider.value )
        let blueCgFloat = CGFloat( self.blueSlider.value )
        
        let currentColor = UIColor(red: redCgFloat, green: greenCgFloat, blue: blueCgFloat, alpha: 1)
        NotificationCenter.default.post(name: .redChanged, object: currentColor)
    }
    
    @IBAction func greenChanged(_ sender: UISlider) {
        let redCgFloat = CGFloat( self.redSlider.value )
        let greenCgFloat = CGFloat( sender.value )
        let blueCgFloat = CGFloat( self.blueSlider.value )
        
        let currentColor = UIColor(red: redCgFloat, green: greenCgFloat, blue: blueCgFloat, alpha: 1)
        NotificationCenter.default.post(name: .redChanged, object: currentColor)
    }
    
    @IBAction func blueChanged(_ sender: UISlider) {
        let redCgFloat = CGFloat( self.redSlider.value )
        let greenCgFloat = CGFloat( self.greenSlider.value )
        let blueCgFloat = CGFloat( sender.value )
        
        let currentColor = UIColor(red: redCgFloat, green: greenCgFloat, blue: blueCgFloat, alpha: 1)
        NotificationCenter.default.post(name: .redChanged, object: currentColor)
    }
}

extension Notification.Name {
    static let redChanged = Notification.Name("redChanged")
    static let greenChanged = Notification.Name("greenChanged")
    static let blueChanged = Notification.Name("blueChanged")
}
