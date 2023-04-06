//
//  KToolBarButton.swift
//  
//
//  Created by Hoen on 2023/04/06.
//

import UIKit

final class KToolBarButton: UIButton {
    
    init(symbolName: String, size: CGFloat, color: UIColor) {
        super.init(frame: .zero)
        
        configure(symbolName, size, color)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(_ symbolName: String, _ size: CGFloat, _ color: UIColor) {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: symbolName)
        config.preferredSymbolConfigurationForImage = .init(pointSize: size)
        config.baseForegroundColor = color
        
        self.configuration = config
    }
}
