//
//  FirstView.swift
//  CollectionViewSelectedImage
//
//  Created by 권정근 on 2/25/24.
//

import UIKit

class FirstView: UIView {
    
    // MARK: - Variables
    static let identifier = "CustomCollectionViewCell"
    
    
    // MARK: - UI Component
    
    let selectImageInfoText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "사진을 선택하세요"
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .black)
        return label
    }()
    
    let selectImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        // button.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        // button.configuration?.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        button.backgroundColor = .lightGray
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .green
        
        collectionView.alwaysBounceVertical = false
        collectionView.showsVerticalScrollIndicator = true

        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        addSubview(selectImageInfoText)
        addSubview(selectImageButton)
        addSubview(collectionView)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        
        let selectImageInfoTextConstraints = [
            selectImageInfoText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            selectImageButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 120)
        ]
        
        let selectImageButtonConstraints = [
            selectImageButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            selectImageButton.topAnchor.constraint(equalTo: selectImageInfoText.bottomAnchor, constant: 15),
            selectImageButton.heightAnchor.constraint(equalToConstant: 100),
            selectImageButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let collectionViewConstraints = [
            collectionView.centerYAnchor.constraint(equalTo: selectImageButton.centerYAnchor),
            collectionView.leadingAnchor.constraint(equalTo: selectImageButton.trailingAnchor, constant: 25),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            collectionView.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        NSLayoutConstraint.activate(selectImageInfoTextConstraints)
        NSLayoutConstraint.activate(selectImageButtonConstraints)
        NSLayoutConstraint.activate(collectionViewConstraints)

        
    }
    
}
