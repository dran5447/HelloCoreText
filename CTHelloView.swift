//
//  CTView.swift
//  coretexttest
//
//  Created by Danielle Neuberger on 7/24/18.
//  Copyright © 2018 Danielle Neuberger. All rights reserved.
//

import UIKit
import CoreText

// New view derived from UIView. Reference this in Main Storyboard's Identity Inspector > Class
class CTHelloView: UIView {

    // Override default draw function
    //https://developer.apple.com/documentation/uikit/uiview/1622529-draw
    override func draw(_ rect: CGRect) {
        // Get graphics context
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Flip coordinates
        context.textMatrix = .identity
        context.translateBy(x: 0, y: bounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        // Create and center path
        let path = CGMutablePath()
        path.addRect(CGRect(origin: CGPoint(x: 0, y: -bounds.size.height/2), size:CGSize(width: CGFloat(bounds.size.width), height: CGFloat(bounds.size.height))))

        // Styling for text
        let defaultFont = UIFont(name: "Arial", size: 30)
        let font = UIFont(name: "Helvetica", size: UIScreen.main.bounds.size.height / 30) ?? defaultFont
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        // Create attributes obj
        let attrs = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: font as Any, .paragraphStyle: paragraphStyle] as [NSAttributedStringKey : Any]
        
        // Create text with attrs
        let str = NSMutableAttributedString(string: "Hello CoreText", attributes: attrs)
        
        // Create framesetter with text, create frame
        let framesetter = CTFramesetterCreateWithAttributedString(str as CFAttributedString)
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, str.length), path, nil)
        
        // Draw frame to provided context
        CTFrameDraw(frame, context)
    }
 

}
