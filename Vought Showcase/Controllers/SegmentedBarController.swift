//
//  SegmentedBarController.swift
//  Vought Showcase
//
//  Created by shikhar on 13/09/24.
//

import UIKit

final class SegmentedBarController: UIViewController, SegmentedProgressBarDelegate {
    
    var images: [String] = ["butcher", "frenchie", "hughei", "mm"]
    var currentIndex = 0
    var imageView: UIImageView!
    var segmentedProgressBar: SegmentedProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupView()
        setupSegmentedProgressBar()
    }
    
    // Set up the Segmented Bar View components
    func setupView() {
        // ImageView to display the stories
        imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        // Gesture Recognizers
        let tapRight = UITapGestureRecognizer(target: self, action: #selector(nextStory))
        tapRight.numberOfTapsRequired = 1
        let tapLeft = UITapGestureRecognizer(target: self, action: #selector(prevStory))
        tapLeft.numberOfTapsRequired = 1
        tapLeft.require(toFail: tapRight)
        
        let rightSide = UIView(frame: CGRect(x: view.bounds.width / 2, y: 0, width: view.bounds.width / 2, height: view.bounds.height))
        let leftSide = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width / 2, height: view.bounds.height))
        
        view.addSubview(rightSide)
        view.addSubview(leftSide)
        
        rightSide.addGestureRecognizer(tapRight)
        leftSide.addGestureRecognizer(tapLeft)
        
        updateStory()
    }
    
    // Set up the segmented progress bar
    func setupSegmentedProgressBar() {
        segmentedProgressBar = SegmentedProgressBar(numberOfSegments: images.count, duration: 5.0)
        segmentedProgressBar.delegate = self
        segmentedProgressBar.frame = CGRect(x: 10, y: 60, width: view.bounds.width - 20, height: 4)
        view.addSubview(segmentedProgressBar)
        segmentedProgressBar.startAnimation()
    }
    
    // Update the displayed story
    func updateStory() {
        let story = images[currentIndex]
        imageView.image = UIImage(named: story)
    }
    
    // Go to the next story
    @objc func nextStory() {
        if currentIndex < images.count - 1 {
            currentIndex += 1
            updateStory()
            segmentedProgressBar.skip() // Skip to next progress bar segment
        } else {
            // If it's the last story, call the delegate's finished method or dismiss the view
            dismiss(animated: true, completion: nil)
        }
    }
    
    // Go to the previous story
    @objc func prevStory() {
        if currentIndex > 0 {
            currentIndex -= 1
            updateStory()
            segmentedProgressBar.rewind() // Rewind to the previous progress bar segment
        }
    }
    
    // SegmentedProgressBarDelegate: Called when a new segment is reached
    func segmentedProgressBarChangedIndex(index: Int) {
        currentIndex = index
        updateStory()
    }
    
    // SegmentedProgressBarDelegate: Called when the progress bar finishes all segments
    func segmentedProgressBarFinished() {
        dismiss(animated: true, completion: nil) // Dismiss the view after all stories are shown
    }
}

