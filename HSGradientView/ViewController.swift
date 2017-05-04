//
//  ViewController.swift
//  HSGradientView
//
//  Created by SongHur on 2017. 5. 3..
//  Copyright © 2017년 gradimma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var gradationView: GradientView!
    @IBOutlet var changeButton: UIButton!

    let gradient = CAGradientLayer()
    var isRevert = false
    let changeDuration = 0.7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradationView.layer.cornerRadius = gradationView.bounds.width / 2.0
        gradationView.layer.masksToBounds = true
        paintBackgroundColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func paintBackgroundColor() {
        
        let bgColorLayer = CAGradientLayer()
        bgColorLayer.frame = self.view.bounds
        
        bgColorLayer.colors = [gradationView.startColor?.withAlphaComponent(0.5).cgColor as Any,
                               gradationView.endColor?.withAlphaComponent(0.5).cgColor as Any]
        
        bgColorLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        bgColorLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        self.view.layer.insertSublayer(bgColorLayer, at: 0)

    }
    
    @IBAction func respondsToChangeColor(sender: UIButton) {
        
        changeButton.isUserInteractionEnabled = false
        gradationView.beginAnimation(duration: changeDuration, isRevert: isRevert)
        isRevert = !isRevert
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + changeDuration) {
            self.changeButton.isUserInteractionEnabled = true
        }
    }


}

