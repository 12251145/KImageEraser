//
//  KImageEraserViewController.swift
//  
//
//  Created by Hoen on 2023/04/05.
//

import UIKit

public protocol KImageEraserViewControllerDelegate: AnyObject {
    func imageEraserViewControllerDoneImageErase(_ viewController: KImageEraserViewController, image: UIImage)
    func imageEraserViewControllerCloseButtonDidTap(_ viewController: KImageEraserViewController)
}

open class KImageEraserViewController: UIViewController {
    
    public weak var delegate: KImageEraserViewControllerDelegate?
    
    private let viewControllerView: KImageEraserViewControllerView

    public init(
        image: UIImage,
        eraserViewMaxWidth: CGFloat = UIScreen.main.bounds.size.width,
        eraserViewMaxHeight: CGFloat = UIScreen.main.bounds.size.width
    ) {
        self.viewControllerView = KImageEraserViewControllerView(
            image: image,
            eraserViewMaxWidth: eraserViewMaxWidth,
            eraserViewMaxHeight: eraserViewMaxHeight
        )
        super.init(nibName: nil, bundle: nil)
        
        self.viewControllerView.imageEraserToolBar.delegate = self
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func loadView() {
        view = viewControllerView
    }
}

//MARK: - KImageEraserToolBarDelegate
extension KImageEraserViewController: KImageEraserToolBarDelegate {
    func doneButtonDidTap() {
        let image = viewControllerView.imageEraserView.maskedImage()
        delegate?.imageEraserViewControllerDoneImageErase(self, image: image)
    }
    
    func closeButtonDidTap() {
        delegate?.imageEraserViewControllerCloseButtonDidTap(self)
    }
}
