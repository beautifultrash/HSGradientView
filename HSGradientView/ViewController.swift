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
    
    let gradient = CAGradientLayer()
    var isRevert = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradationView.layer.cornerRadius = gradationView.bounds.width / 2.0
        gradationView.layer.masksToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func respondsToChangeColor(sender: UIButton) {
        gradationView.beginAnimation(duration: 1.0, isRevert: isRevert)
        isRevert = !isRevert
    }


}

