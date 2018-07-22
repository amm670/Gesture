//
//  ViewController.swift
//  gesture
//
//  Created by Alexandra on 7/20/18.
//  Copyright © 2018 Montgomerys Designs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var fileImageView: UIImageView!
    @IBOutlet var trashImageView: UIImageView!
    var fileLocation = CGPoint(x:10, y:10)
    
    
    var fileViewOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPanGesture(view: fileImageView)
        fileViewOrigin = fileImageView.frame.origin
        view.bringSubview(toFront: fileImageView)
    }
    
    func addPanGesture(view: UIView) {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    // Refactor
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        
        let fileView = sender.view!
        
        switch sender.state {
            
        case .began, .changed:
            moveViewWithPan(view: fileImageView, sender: sender)
            
        case .ended:
            if fileView.frame.intersects(trashImageView.frame) {
                deleteView(view: fileImageView)
            } else {
                returnViewToOrigin(view: fileImageView)
            }
            
        default:
            break
        }
    }
    
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    
    func returnViewToOrigin(view: UIView) {
        
        UIView.animate(withDuration: 0.3, animations: {
            view.frame.origin = self.fileViewOrigin
        })
    }
    
    
    func deleteView(view: UIView) {
        
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0.0
        })
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        print("Return to origin")
        //finish
        
    }
}

