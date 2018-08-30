//
//  HomeController.swift
//  LBTA_YouTube
//
//  Created by Vlado Velkovski on 8/17/18.
//  Copyright © 2018 Vlado Velkovski. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //    var videos: [Video] = {
    //        var kanyeChannel = Channel()
    //        kanyeChannel.channelName = "KanyeIsTheBestChannel"
    //        kanyeChannel.profileImageName = "kanye_profile"
    //
    //        var blankSpaceVideo = Video()
    //        blankSpaceVideo.title = "Taylor Swift - Blank Space"
    //        blankSpaceVideo.thumbnailImageName = "taylor_swift_blank_space"
    //        blankSpaceVideo.channel = kanyeChannel
    //        blankSpaceVideo.numberOfViews = 219324084
    //
    //        var badBloodVideo = Video()
    //        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kanye West"
    //        badBloodVideo.thumbnailImageName = "taylor_swift_bad_blood"
    //        badBloodVideo.channel = kanyeChannel
    //        badBloodVideo.numberOfViews = 1342332334234
    //        return [blankSpaceVideo, badBloodVideo]
    //    }()
    
    var videos: [Video]?
    
    func fetchVideos() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            if error != nil {
                print(error)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                self.videos = [Video]()
                for dictionary in json as! [[String: AnyObject]] {
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.numberOfViews = dictionary["number_of_views"] as? NSNumber
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    let channel = Channel()
                    
                    channel.channelName = channelDictionary["name"] as? String
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    video.channel = channel
                    
                    //print(video.thumbnailImageName)
                    //print(video.channel?.profileImageName)
                    
                    self.videos?.append(video)
                }
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            
            }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        collectionView?.backgroundColor = UIColor.white
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        navigationItem.titleView = titleLabel
        
        collectionView?.register(VIdeoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenuBar()
        setupNavBarButtons()
        
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    private func setupNavBarButtons() {
        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    
    @objc func handleSearch() {
        print("search")
    }

    let settingsLauncher = SettingsLauncher()
    
    @objc func handleMore() {
        print("more")
        settingsLauncher.showSettings()
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VIdeoCell
        //        let video = videos[indexPath.item]
        //        cell.thumbnailImageView.image = UIImage(named: video.thumbnailImageName!)
        //        cell.titleLabel.text = video.title
        
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

