//
//  KImageEraserViewController.swift
//  
//
//  Created by Hoen on 2023/04/05.
//

import UIKit

open class KImageEraserViewController: UIViewController {
    
    private let imageEraserView: KImageEraserView
        
    let maxWidth: CGFloat
    let maxHeight: CGFloat
    
    public init(
        image: UIImage,
        maxWidth: CGFloat = UIScreen.main.bounds.size.width,
        maxHeight: CGFloat = UIScreen.main.bounds.size.width,
        eraserViewY: CGFloat = 150
    ) {
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
        
        let width: CGFloat
        let height: CGFloat
        
        if image.size.width < image.size.height {
            let ratio = image.size.width / image.size.height
            height = maxHeight
            width = round(height * ratio)
        } else {
            let ratio = image.size.height / image.size.width
            width = maxWidth
            height = round(width * ratio)
        }

        let x = round((UIScreen.main.bounds.width - width) / 2)
        let y = round(eraserViewY)
        
        self.imageEraserView = KImageEraserView(
            frame: .init(x: x, y: y, width: width, height: height),
            image: image
        )
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageEraserView)
    }

    func maskedImage() -> UIImage {        
        return imageEraserView.maskedImage()
    }
}
