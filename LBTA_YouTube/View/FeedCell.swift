//
//  FeedCell.swift
//  LBTA_YouTube
//
//  Created by Vlado Velkovski on 9/10/18.
//  Copyright © 2018 Vlado Velkovski. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var videos: [Video]?
    
    let cellId = "cellId"
    
    func fetchVideos() {
        
        ApiService.sharedInstance.fetchVideos { videos in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    
    override func setupViews() {
        super.setupViews()
        fetchVideos()
        
        //    let colors: [UIColor] = [.blue, .yellow, .green, .gray]
        //    ll.backgroundColor = colors[indexPath.item]
        
        backgroundColor = .brown
        
        addSubview(collectionView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(VIdeoCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VIdeoCell
        //        let video = videos[indexPath.item]
        //        cell.thumbnailImageView.image = UIImage(named: video.thumbnailImageName!)
        //        cell.titleLabel.text = video.title
        
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSize(width: frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
        
    }
    
    
}
