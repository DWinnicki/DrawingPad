//
//  ViewController.swift
//  DrawingPad
//
//  Created by David Winnicki on 2017-06-09.
//  Copyright © 2017 Winnicki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvas: UIImageView!
    var start: CGPoint?
    var color: CGColor = UIColor.blue.cgColor
    
    @IBAction func buttonClearTouched(_ sender: UIBarButtonItem) {
        canvas.image = nil
    }

    @IBAction func buttonBlueTouched(_ sender: UIBarButtonItem) {
        color = UIColor.blue.cgColor
    }
    
    @IBAction func buttonBlackTouched(_ sender: UIBarButtonItem) {
        color = UIColor.black.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            start = touch.location(in: view)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let end = touch.location(in: view)
            if let start = self.start {
                draw(from: start, to: end)
            }
            self.start = end
        }
    }
    
    func draw(from startPoint: CGPoint, to endPoint: CGPoint) {
        UIGraphicsBeginImageContext(canvas.frame.size)
        let context = UIGraphicsGetCurrentContext()
        canvas.image?.draw(in: CGRect(x: 0.0, y: 0.0, width: canvas.frame.size.width, height: canvas.frame.size.height))
        context?.setLineWidth(3)
        context?.setStrokeColor(color)
        context?.beginPath()
        context?.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
        context?.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
        context?.strokePath()
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        canvas.image = newImage
    }
}
