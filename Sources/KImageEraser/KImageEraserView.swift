//
//  KImageEraserView.swift
//  
//
//  Created by Hoen on 2023/04/05.
//

import UIKit

final class KImageEraserView: UIView {
    private var originImage: UIImage
    private var maskImage: UIImage?
        
    private var thumbnailView = UIImageView()
    private var drawingView = KDrawingView()
    
    var image: UIImage {
        return originImage
    }
    
    init(image: UIImage) {
        self.originImage = image
        self.thumbnailView.image = image
        super.init(frame: .zero)
        
        addSubview(thumbnailView)
        addSubview(drawingView)
        
        drawingView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    func layout() {
        thumbnailView.frame = bounds
        drawingView.frame = bounds
    }
    
    func maskedImage() -> UIImage {
        guard let maskImage else { return originImage }
        
        UIGraphicsBeginImageContextWithOptions(originImage.size, false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        context?.interpolationQuality = .high
        
        originImage.draw(in: .init(x: 0, y: 0, width: originImage.size.width, height: originImage.size.height), blendMode: .normal, alpha: 1.0)
        maskImage.draw(in: .init(x: 0, y: 0, width: originImage.size.width, height: originImage.size.height), blendMode: .destinationOut, alpha: 1.0)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return originImage }
        
        UIGraphicsEndImageContext()
        
        return image
    }
}

// MARK: - DrawingViewDelegate
extension KImageEraserView: KDrawingViewDelegate {
    
    func drawEnded(_ image: UIImage) {
        drawThumbnail(image)
        drawMask()
        
        drawingView.image = nil
    }
    
    private func drawThumbnail(_ image: UIImage) {
        UIGraphicsBeginImageContextWithOptions(thumbnailView.bounds.size, false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        context?.interpolationQuality = .high
        
        thumbnailView.image?.draw(in: thumbnailView.bounds, blendMode: .normal, alpha: 1.0)
        image.draw(in: thumbnailView.bounds, blendMode: .destinationOut, alpha: 1.0)
        
        thumbnailView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
    
    private func drawMask() {
        UIGraphicsBeginImageContextWithOptions(drawingView.bounds.size, false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        context?.interpolationQuality = .high
        
        maskImage?.draw(in: drawingView.bounds, blendMode: .normal, alpha: 1.0)
        drawingView.image?.draw(in: drawingView.bounds, blendMode: .normal, alpha: 1.0)
        
        maskImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
}
