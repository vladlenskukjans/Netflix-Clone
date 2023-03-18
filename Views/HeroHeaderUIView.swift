//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by Vladlens Kukjans on 13/03/2023.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        //image.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func addGradient() {
    let gradientLayer = CAGradientLayer()
        gradientLayer.colors =  [
            
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        
        layer.addSublayer(gradientLayer)
        gradientLayer.frame = bounds
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        setConstraints()
    }
    
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else { return }
        heroImageView.sd_setImage(with: url)
    }
    
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
        
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 65),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 120),
                        
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -65),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
        ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
