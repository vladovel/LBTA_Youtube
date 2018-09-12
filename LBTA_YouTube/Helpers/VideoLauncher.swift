//
//  VideoLauncher.swift
//  LBTA_YouTube
//
//  Created by Vlado Velkovski on 9/12/18.
//  Copyright © 2018 Vlado Velkovski. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView, AVAudioPlayerDelegate {
    
    var player: AVPlayer?
    var isVideoPlaying = true
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0)
        return view
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.activityIndicatorViewStyle = .whiteLarge
        spinner.startAnimating()
        return spinner
    }()
    
    let pausePlayButton: UIButton = {
        let pb = UIButton(type: .system)
        let image = UIImage(named: "pause")
        pb.setImage(image, for: .normal)
        pb.tintColor = UIColor.white
        pb.isHidden = true
        
        pb.addTarget(self, action: #selector(handlePausePlay), for: .touchUpInside)
        
        // pb.translatesAutoresizingMaskIntoConstraints = false
        return pb
    }()
    
    @objc func handlePausePlay() {
        print("Pausing player ...")
        if isVideoPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
//            isVideoPlaying = false
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
//            isVideoPlaying = true
        }
        
        isVideoPlaying = !isVideoPlaying
        // pausePlayButton.removeFromSuperview()
//        controlsContainerView.addSubview(pausePlayButton)
//        pausePlayButton.frame.size = CGSize(width: 60, height: 60)
//        pausePlayButton.center = controlsContainerView.center

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        controlsContainerView.addSubview(spinner)
        
        spinner.center = CGPoint(x: controlsContainerView.frame.width / 2, y: controlsContainerView.frame.height / 2)
        
        backgroundColor = UIColor.black
        
    }
    
    private func setupPlayerView() {
        let urlString = "https://itunesu-assets.itunes.apple.com/apple-assets-us-std-000001/CobaltPublic122/v4/02/4d/e9/024de95b-8afc-89b9-e4ba-ef8e08d5d13f/324-3685031694599443811-01_1_09_17_720p3000_for_iTunes.m4v"
        
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            print("Trying to play video from url: \(url)")
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            spinner.stopAnimating()
            controlsContainerView.backgroundColor = UIColor.clear
            
            controlsContainerView.addSubview(pausePlayButton)
            
            pausePlayButton.frame.size = CGSize(width: 50, height: 50)
            pausePlayButton.center = controlsContainerView.center
            pausePlayButton.isHidden = false

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeObserver(self, forKeyPath: "currentItem.loadedTimeRanges")
    }
    
}


class VideoLauncher: NSObject {
    
    func showVideoPlayer() {
        print("Showing video player animation ...")
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        if let keyWindow = UIApplication.shared.keyWindow {
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            keyWindow.addSubview(view)
            
            let videoPlayerView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: keyWindow.frame.width * (9 / 16)))
            view.addSubview(videoPlayerView)
            
            //            view.addConstraintsWithFormat(format: "H:|[v0]|", views: videoPlayerView)
            //            view.addConstraintsWithFormat(format: "V:|[v0]", views: videoPlayerView)
            //            videoPlayerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            //            videoPlayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: keyWindow.frame.width * 0.33).isActive = true
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: keyWindow.frame.height)
            }) { (completedAnimation) in
                // do something here ...
                UIApplication.shared.isStatusBarHidden = true
            }
        }
    }
}
