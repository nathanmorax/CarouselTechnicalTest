//
//  TvShowCollectionCell.swift
//  CarouselTechnicalTest
//
//  Created by Xcaret Mora on 18/04/24.
//

import UIKit

class TvShowCollectionCell: UICollectionViewCell {
    
    let imageTV = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        imageTV.layer.cornerRadius = 12
        imageTV.clipsToBounds = true
        
    }
    
    private func constraint() {
        
        addSubview(imageTV)
        
        imageTV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageTV.topAnchor.constraint(equalTo: self.topAnchor),
            imageTV.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageTV.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageTV.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
        
    }
    
}
