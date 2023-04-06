//
//  KDrawingView.swift
//  
//
//  Created by Hoen on 2023/04/05.
//

import UIKit

final class KDrawingView: UIImageView {
    weak var delegate: KDrawingViewDelegate?
        
    private var color: UIColor = .black
    private var brushWidth: CGFloat = 20.0
    
    private var lastPoint: CGPoint = .zero
    private var swiped = false
    
    init() {
        super.init(frame: .zero)
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        swiped = false
        lastPoint = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        swiped = true
        let currentPoint = touch.location(in: self)
        drawLine(from: lastPoint, to: currentPoint)
        
        lastPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLine(from: lastPoint, to: lastPoint)
        }
        
        if let image {
            delegate?.drawEnded(image)
        }
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    private func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)

        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.interpolationQuality = .high

        image?.draw(in: bounds)

        context.move(to: fromPoint)
        context.addLine(to: toPoint)

        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(color.cgColor)

        context.strokePath()

        image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
    }
}
