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
    @IBOutlet var pickStartColorButton: UIButton!
    @IBOutlet var pickEndColorButton: UIButton!
    @IBOutlet var colorPickerView: UIView!
    @IBOutlet var bgView: UIView!

    @IBOutlet var colorPicker: HSBColorPicker!
    
    let gradient = CAGradientLayer()
    var isRevert = false
    let changeDuration = 0.7
    let bgColorLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradationView.layer.cornerRadius = gradationView.bounds.width / 2.0
        gradationView.layer.masksToBounds = true
        colorPicker.layer.cornerRadius = colorPicker.bounds.width / 2.0
        colorPicker.layer.masksToBounds = true
        
        pickStartColorButton.backgroundColor = gradationView.startColor
        pickEndColorButton.backgroundColor = gradationView.endColor
        pickStartColorButton.layer.cornerRadius = pickStartColorButton.bounds.width / 2.0
        pickEndColorButton.layer.cornerRadius = pickEndColorButton.bounds.width / 2.0

        pickStartColorButton.center = colorPicker.getPointForColor(color: gradationView.startColor)
        pickEndColorButton.center = colorPicker.getPointForColor(color: gradationView.endColor)
        
        let tapGestureRecogniger = UITapGestureRecognizer.init(target: self, action: #selector(showPickerView))
        let tapPickerGestureRecogniger = UITapGestureRecognizer.init(target: self, action: #selector(showPickerView))

        self.bgView.addGestureRecognizer(tapGestureRecogniger)
        self.colorPickerView.addGestureRecognizer(tapPickerGestureRecogniger)
        
        pickStartColorButton.addTarget(self, action: #selector(respondsToDragColorButton), for: UIControlEvents.touchDragInside)
        pickEndColorButton.addTarget(self, action: #selector(respondsToDragColorButton), for: UIControlEvents.touchDragInside)

        paintBackgroundColor()
        
        bgColorLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(bgColorLayer, at: 0)

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    func showPickerView() {
        UIView.animate(withDuration: 0.4, animations: {
            if self.colorPickerView.isHidden == true {
                self.colorPickerView.isHidden = false
                self.colorPickerView.alpha = 1.0
            } else {
                self.colorPickerView.alpha = 0.0
            }
        }) { (completion) in
            if self.colorPickerView.alpha == 0.0 {
                self.colorPickerView.isHidden = true
            } else {
                self.colorPickerView.isHidden = false
            }
        }
    }
    
    func paintBackgroundColor() {
        
        bgColorLayer.colors = [gradationView.startColor?.withAlphaComponent(0.5).cgColor as Any,
                               gradationView.endColor?.withAlphaComponent(0.5).cgColor as Any]
        bgColorLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        bgColorLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

    }
    
    @IBAction func respondsToChangeColor(sender: UIButton) {
        
        changeButton.isUserInteractionEnabled = false
        gradationView.beginAnimation(duration: changeDuration, isRevert: isRevert)
        isRevert = !isRevert
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + changeDuration) {
            self.changeButton.isUserInteractionEnabled = true
        }
    }

    @IBAction func respondsToDragColorButton(sender: UIButton, event: UIEvent) {
        
        let touchPosition = event.allTouches?.first?.location(in: colorPicker)
        
        if (touchPosition?.x)! > CGFloat(0.0) && (touchPosition?.x)! < colorPicker.bounds.width
            && (touchPosition?.y)! > CGFloat(0.0) && (touchPosition?.y)! < colorPicker.frame.height {
            
            if sender == pickStartColorButton {
                pickStartColorButton.center = (event.allTouches?.first?.location(in: colorPicker))!
                pickStartColorButton.backgroundColor = colorPicker.getColorAtPoint(point: pickStartColorButton.center)
            } else if sender == pickEndColorButton {
                pickEndColorButton.center = (event.allTouches?.first?.location(in: colorPicker))!
                pickEndColorButton.backgroundColor = colorPicker.getColorAtPoint(point: pickEndColorButton.center)
            }
            
            gradationView.startColor = pickStartColorButton.backgroundColor
            gradationView.endColor = pickEndColorButton.backgroundColor
            gradationView.updateGradientColor()
            paintBackgroundColor()
            
        }
        
    }
    
    

}

