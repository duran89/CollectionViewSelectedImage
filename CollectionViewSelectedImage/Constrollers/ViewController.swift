//
//  ViewController.swift
//  CollectionViewSelectedImage
//
//  Created by 권정근 on 2/25/24.
//

import UIKit
import BSImagePicker
import PhotosUI
import Photos

class ViewController: UIViewController {
    
    let firstView = FirstView()
    let secondView = SecondView()
    
    // MARK: - Variables
    private var images: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        self.navigationItem.title = "사진 선택"
        navigationController?.navigationBar.backgroundColor = .gray
        
        view.addSubview(firstView)
        view.addSubview(secondView)
        
        firstView.translatesAutoresizingMaskIntoConstraints = false
        secondView.translatesAutoresizingMaskIntoConstraints = false
        
        self.firstView.collectionView.delegate = self
        self.firstView.collectionView.dataSource = self
        
        firstView.selectImageButton.addTarget(self, action: #selector(didTapImage), for: .touchUpInside)
        
        configureConstriants()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.firstView.collectionView.reloadData()
    }
    
    @objc func didTapImage() {
        print("버튼이 눌림")
        testMain()
    }
    
    func testMain() {
            // [로직 처리 수행]
            DispatchQueue.main.async {
                // [앨범의 사진에 대한 접근 권한 확인 실시]
                PHPhotoLibrary.requestAuthorization( { status in
                    switch status{
                    case .authorized:
                        // [앨범 열기 수행 실시]
                        self.openPhoto()
                        break
                    case .denied:
                        break
                    case .notDetermined:
                        break
                    case .restricted:
                        break
                    default:
                        break
                    }
                })
            }
        }
    
        // MARK: - [앨범 열기 수행 실시]
        func openPhoto(){
            let imagePicker = ImagePickerController()
            imagePicker.settings.theme.selectionStyle = .numbered // 이미지 선택 시 표시
            imagePicker.settings.theme.backgroundColor = .darkGray // 배경 색상
            imagePicker.albumButton.tintColor = .black // 버튼 색상
            imagePicker.cancelButton.tintColor = .black // 버튼 색상
            imagePicker.doneButton.tintColor = .black // 버튼 색상
            imagePicker.settings.theme.selectionFillColor = .black // 선택 배경 색상 (Circle)
            imagePicker.settings.theme.selectionStrokeColor = .white // 선택 표시 색상 (Circle)
            imagePicker.settings.selection.max = 3 // 최대 선택 개수
            imagePicker.settings.fetch.assets.supportedMediaTypes = [.image] // 이미지 타입
            // [화면 전환 실시]
            self.presentImagePicker(imagePicker, select: { (asset) in
            }, deselect: { (asset) in
            }, cancel: { (assets) in
            }, finish: { (assets) in
                // [선택한 이미지 사이즈 변환]
                if assets.count != 0 {
                    for i in 0..<assets.count {
                        let imageManager = PHImageManager.default()
                        let option = PHImageRequestOptions()
                        option.isSynchronous = true
                        var thumbnail = UIImage()
                        imageManager.requestImage(for: assets[i],
                                                  targetSize: CGSize(width: 200, height: 200),
                                                  contentMode: .aspectFit,
                                                  options: option) { (result, info) in
                            thumbnail = result!
                        }
                        
                        let data = thumbnail.jpegData(compressionQuality: 0.7)
                        let newImage = UIImage(data: data!)
                        
                        // [이미지 뷰에 표시 실시]
                        // self.detailView.mainImageView.image = newImage! as UIImage
                        
                        // [배열에 저장할 것]
                        self.images.append(newImage!)
                    }
                }
                
             })
        }
    
    
    private func configureConstriants() {
        
        let firstViewConstraints = [
            firstView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstView.topAnchor.constraint(equalTo: view.topAnchor),
            firstView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            firstView.heightAnchor.constraint(equalToConstant: view.frame.height / 3)
        ]
        
        let secondViewConstraints = [
            secondView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor),
            secondView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secondView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(firstViewConstraints)
        NSLayoutConstraint.activate(secondViewConstraints)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else { fatalError("ERROR")}
        
        cell.myImageView.image = images[indexPath.item]
        
        return cell
    }
}
