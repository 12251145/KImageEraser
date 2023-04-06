//
//  KImageEraserViewControllerView.swift
//  
//
//  Created by Hoen on 2023/04/06.
//

import UIKit

final class KImageEraserViewControllerView: UIView {
    
    private(set) var imageEraserView: KImageEraserView
    private(set) var imageEraserToolBar: KImageEraserToolBar
        
    let eraserViewMaxWidth: CGFloat
    let eraserViewMaxHeight: CGFloat
    
    public var isImageProcessing: Bool = false {
        didSet {
            imageEraserToolBar.isProcessing = isImageProcessing
        }
    }
    
    public init(
        image: UIImage,
        eraserViewMaxWidth: CGFloat,
        eraserViewMaxHeight: CGFloat
    ) {
           
        self.eraserViewMaxWidth = eraserViewMaxWidth
        self.eraserViewMaxHeight = eraserViewMaxHeight
        
        self.imageEraserView = KImageEraserView(image: image)
        self.imageEraserToolBar = KImageEraserToolBar()

        super.init(frame: .zero)
        
        self.backgroundColor = .black
        self.addSubview(imageEraserView)
        self.addSubview(imageEraserToolBar)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    private func layout() {
        imageEraserViewLayout()
        imageEraserToolBarLayout()
    }
    
    private func imageEraserViewLayout() {
        let image = imageEraserView.image
        let eraserViewHeight: CGFloat
        let eraserViewWidth: CGFloat

        if image.size.width < image.size.height {
            let ratio = image.size.width / image.size.height
            eraserViewHeight = eraserViewMaxHeight
            eraserViewWidth = round(eraserViewHeight * ratio)
        } else {
            let ratio = image.size.height / image.size.width
            eraserViewWidth = eraserViewMaxWidth
            eraserViewHeight = round(eraserViewWidth * ratio)
        }

        let eraserViewYMargin = (eraserViewMaxHeight - eraserViewHeight) / 2
        let eraserViewX = round((bounds.size.width - eraserViewWidth) / 2)
        let eraserViewY = round(((bounds.size.height / 2) - (eraserViewHeight / 2)) / 1.5) + eraserViewYMargin
        
        imageEraserView.frame = .init(x: eraserViewX, y: eraserViewY, width: eraserViewWidth, height: eraserViewHeight)
    }
    
    private func imageEraserToolBarLayout() {
        let toolBarHeight: CGFloat = 50
        var toolBarY: CGFloat = 0
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            var bottomPadding = window.safeAreaInsets.bottom
            bottomPadding += 20
            
            toolBarY = bounds.size.height - bottomPadding - toolBarHeight
        }
        
        imageEraserToolBar.frame = .init(x: 0, y: toolBarY, width: bounds.size.width, height: toolBarHeight)
    }
}
