//
//  UIImageView.swift
//  Tinder
//
//  Created by Matheus Barbosa on 10/03/22.
//

import UIKit

extension UIImageView {
    
    static func fotoImageView(named: String? = nil) -> UIImageView {
        let imageView = UIImageView()
        if let named = named {
            imageView.image = UIImage.init(named: named)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    static func iconCard(named: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: named)
        imageView.size(size: .init(width: 70, height: 70))
        imageView.alpha = 0.0
        return imageView
    }
}
