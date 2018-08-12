//
//  UILabel+Ex.swift
//
//  Created by Augus on 6/7/15.
//  Copyright (c) 2015 Augus. All rights reserved.
//

import UIKit

// calculate size of UILabel with string
func ausFrameSizeForText(text: NSString, maximumSize: CGSize) -> CGRect {
    let attrString = NSAttributedString(string: text as String)
    return attrString.boundingRect(with: maximumSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
    
}

func ausFrameSizeForText(text: NSString, font: UIFont, maximumSize: CGSize) -> CGRect {
    return text.boundingRect(with: maximumSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
}

func ausFrameSizeForText(label: UILabel, text: NSString, maximum: CGSize) -> CGRect {
    label.attributedText = NSAttributedString(string: text as String)
    let requireSize = label.sizeThatFits(maximum)
    var labelFrame = label.frame
    labelFrame.size.height = requireSize.height
    label.frame = labelFrame
    return label.frame
}


extension UILabel {
    
    func isTruncated() -> Bool {
        if let string = text {
            let size = string.boundingRect(
                with: CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude),
                options: NSStringDrawingOptions.usesLineFragmentOrigin,
                attributes: [NSAttributedString.Key.font: font],
                context: nil).size
            
            if size.height > bounds.size.height {
                return true
            }
        }
        return false
    }
    
    /**
     Methods to allow using HTML code with CoreText
     
     */
    func ausAttributedText(data: String) {
        do {
            let formatedData = (data as NSString).trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            let text = try NSAttributedString(data: formatedData.data(using: String.Encoding.unicode,allowLossyConversion: false)!,
                                              options: [.documentType: NSAttributedString.DocumentType.html],
                                              documentAttributes: nil)
            self.attributedText = text
        }catch{
            NSLog("something error with NSAttributedString")
        }
    }
    
    func ausGetLabelSize() -> CGSize {
        let constraint = CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude)
        
        let context = NSStringDrawingContext()
        let boundingBox = self.text?.boundingRect(with: constraint, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font], context: context).size
        let size = CGSize(width: ceil(boundingBox!.width), height: ceil(boundingBox!.height))
        
        return size
    }
    
    func ausGetLabelNumberOfLines() -> Int {
        let textStorage = NSTextStorage(string: self.text!, attributes: [NSAttributedString.Key.font: self.font])
        
        let textContainer = NSTextContainer(size: self.ausGetLabelSize())
        textContainer.lineBreakMode = .byWordWrapping
        textContainer.maximumNumberOfLines = 0
        textContainer.lineFragmentPadding = 0
        
        let layoutManager = NSLayoutManager()
        layoutManager.textStorage = textStorage
        layoutManager.addTextContainer(textContainer)
        
        var numberOfLines = 0
        var index = 0
        var lineRange : NSRange = NSMakeRange(0, 0)
        
        while index < layoutManager.numberOfGlyphs {
            numberOfLines += 1
            layoutManager.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
            index = NSMaxRange(lineRange)
        }
        
        return max(numberOfLines - 1, 0)
    }
    
    func ausCalculateLabelSizeToFit() {
        
        let constraint = CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude)
        
        let context = NSStringDrawingContext()
        let boundingBox = self.text?.boundingRect(with: constraint, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font], context: context).size
        let size = CGSize(width: ceil(boundingBox!.width), height: ceil(boundingBox!.height))
        
        var frame = self.frame
        frame.size.height = size.height
        self.frame = frame
    }
    
    func ausReturnFrameSizeAfterResizingLabel() -> CGSize {
        let fixedWidth = self.frame.size.width
        self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = self.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        self.frame = newFrame
        return self.frame.size
    }
}
