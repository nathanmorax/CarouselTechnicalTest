//
//  TvShowViewController.swift
//  CarouselTechnicalTest
//
//  Created by Xcaret Mora on 18/04/24.
//

import UIKit
import SDWebImage
import SafariServices

class TvShowViewController: UIViewController {
    
    fileprivate let cell = "cell"
    let infoLabel = UILabel()
    let backGround = UIImageView()
    
    let viewModel = TvShowViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        constraint()
        fetchData()
        
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    private func configure() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(TvShowCollectionCell.self, forCellWithReuseIdentifier: cell)
        
        
        backGround.image = UIImage(named: "backGround")
        backGround.contentMode = .scaleAspectFill
        
        infoLabel.layer.cornerRadius = 20
        infoLabel.clipsToBounds = true
        infoLabel.text = "Explora tus programas"
        infoLabel.textColor = .white
        infoLabel.backgroundColor = .red
        infoLabel.textAlignment = .center
        infoLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
    }
    
    private func constraint() {
        
        view.addSubview(backGround)
        view.sendSubviewToBack(backGround)
        
        view.addSubview(collectionView)
        view.addSubview(infoLabel)
        
        backGround.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            backGround.topAnchor.constraint(equalTo: view.topAnchor),
            backGround.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backGround.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backGround.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.widthAnchor.constraint(equalToConstant: 200),
            infoLabel.heightAnchor.constraint(equalToConstant: 40),
            infoLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
    
        ])
    }
    
    private func fetchData() {
        
        viewModel.getShowTv {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func fetchUrlWebView(urlString: String) {
        
        viewModel.getUrlWebView(urlString: urlString) {
            DispatchQueue.main.async {
                let _ = self.viewModel.resultTvUrl.first?.title
                if  let url = URL(string: self.viewModel.resultTvUrl.first?.url ?? "") {
                    let safariVC = SFSafariViewController(url: url)
                    safariVC.preferredControlTintColor = .red
                    self.present(safariVC, animated: true, completion: nil)
                }
            }
        }
    }
}

extension TvShowViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Count:", viewModel.resultTv.count)
        
        return viewModel.resultTv.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: cell, for: indexPath)
        if let cell = cell as? TvShowCollectionCell {
            let url = URL(string: viewModel.resultTv[indexPath.item].imagen ?? "")
            cell.imageTV.sd_setImage(with: url)
        }
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data = viewModel.resultTv[indexPath.item]
        
        if let item = data.itemPrivate, item != "1" {
            guard let urlString = data.programa else { return }
            fetchUrlWebView(urlString: urlString)
        } else {
            Alert.showAlert(on: self, with: "TV Show", message: "Contenido no disponible")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 25, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 8, left: 8, bottom: 8, right: 0)
    }
}
