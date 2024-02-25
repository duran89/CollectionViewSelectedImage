//
//  CustomCollectionViewCell.swift
//  CollectionViewSelectedImage
//
//  Created by 권정근 on 2/25/24.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    static let identifier = "CustomCollectionViewCell"
    
    // MARK: - UI Components
    var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "questionmark")
        imageView.tintColor = .systemGray
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brown
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = .systemMint
        
        self.addSubview(myImageView)
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            myImageView.topAnchor.constraint(equalTo: self.topAnchor),
            myImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            myImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.myImageView.image = nil
    }
    
}
