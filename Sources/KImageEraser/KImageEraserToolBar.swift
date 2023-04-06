//
//  KImageEraserToolBar.swift
//  
//
//  Created by Hoen on 2023/04/06.
//

import UIKit

protocol KImageEraserToolBarDelegate: AnyObject {
    func doneButtonDidTap()
    func closeButtonDidTap()
}

final class KImageEraserToolBar: UIView {
    weak var delegate: KImageEraserToolBarDelegate?
    
    let buttonSize: CGFloat = 40
    
    let doneButton = KToolBarButton(symbolName: "checkmark", size: 14, color: .white)
    let closeButton = KToolBarButton(symbolName: "xmark", size: 14, color: .white)
    
    public var isProcessing: Bool = false {
        didSet {
            toolActivate(by: isProcessing)
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        addSubview(doneButton)
        addSubview(closeButton)
        
        setToolBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    private func layout() {
        let buttonCount = CGFloat(self.subviews.count)
        let width = bounds.size.width
        let spacing = width / (buttonCount + 1)
        let y = bounds.size.height / 2 - (buttonSize / 2)
        
        self.subviews.enumerated().forEach { (i, button) in
            let x = spacing * CGFloat(i + 1) - (buttonSize / 2)
            button.frame = .init(x: x, y: y, width: buttonSize, height: buttonSize)
        }
    }
    
    private func setToolBar() {
        setDoneButton()
        setCloseButton()
    }
    
    private func setDoneButton() {
        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
    }
    
    private func setCloseButton() {
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    private func toolActivate(by isProcessing: Bool) {
        if isProcessing {
            doneButton.isEnabled = false
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.doneButton.alpha = 0.5
            }
        } else {
            doneButton.isEnabled = true
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.doneButton.alpha = 1.0
            }
        }
    }
    
    @objc
    private func done() {
        delegate?.doneButtonDidTap()
    }
    
    @objc
    private func close() {
        delegate?.closeButtonDidTap()
    }
}
