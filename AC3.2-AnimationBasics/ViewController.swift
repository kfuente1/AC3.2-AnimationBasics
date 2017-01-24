//
//  ViewController.swift
//  AC3.2-AnimationBasics
//
//  Created by Louis Tur on 1/22/17.
//  Copyright © 2017 Access Code. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  static let animationDuration: TimeInterval = 2.0
  static let squareSize = CGSize(width: 100.0, height: 100.0)
    
    let blueAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .linear, animations: nil)
    let tealAnimator = UIViewPropertyAnimator(duration: animationDuration, curve:.easeIn,  animations: nil)
     let yellowAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeOut, animations: nil)
     let orangeAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut, animations: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewHierarchy()
    configureConstraints()
    
    addGesturesAndActions()
  }
    override func viewDidAppear(_ animated: Bool) {
        //self.animateDarkBlueViewWithFrames()
//       self.animateDarkBlueViewWithSnapkit()
//       self.animateTealViewWithSnapkit()
//        self.animateYellowViewWithSnapkit()
//        self.animateOrangeViewWithSnapkit()
    }
  
    private func configureConstraints() {
        let _ = [darkBlueView, tealView,yellowView, orangeView].map{$0.snp.removeConstraints()}
    // blue
    darkBlueView.snp.makeConstraints { (view) in
      view.leading.equalToSuperview().offset(20.0)
      view.top.equalToSuperview().offset(20.0)
      view.size.equalTo(ViewController.squareSize)
    
    }
    // teal
    tealView.snp.makeConstraints { (view) in
        view.leading.equalToSuperview().offset(20.0)
        view.top.equalTo(darkBlueView.snp.bottom).offset(20.0)
        view.size.equalTo(ViewController.squareSize)
    }
    // yellow
    yellowView.snp.makeConstraints { (view) in
        view.leading.equalToSuperview().offset(20.0)
        view.top.equalTo(tealView.snp.bottom).offset(20.0)
        view.size.equalTo(ViewController.squareSize)
    }
    // orange
    orangeView.snp.makeConstraints { (view) in
        view.leading.equalToSuperview().offset(20.0)
        view.top.equalTo(yellowView.snp.bottom).offset(20.0)
        view.size.equalTo(ViewController.squareSize)
    }
    
    // button
    animateButton.snp.makeConstraints { (view) in
      view.centerX.equalToSuperview()
      view.bottom.equalToSuperview().inset(50.0)
      view.width.greaterThanOrEqualTo(100.0)
    }
    //reset button 
    resetAnimationsButton.snp.makeConstraints { (view) in
        view.centerX.equalToSuperview()
        view.bottom.equalToSuperview().inset(25.0)
        view.width.greaterThanOrEqualTo(100.0)
        
    }
    
  }
  
  private func setupViewHierarchy() {
    self.view.backgroundColor = .white
    
    self.view.addSubview(darkBlueView)
    self.view.addSubview(animateButton)
    self.view.addSubview(resetAnimationsButton)
    self.view.addSubview(tealView)
    self.view.addSubview(yellowView)
    self.view.addSubview(orangeView)
  }
  
  private func addGesturesAndActions() {
    self.animateButton.addTarget(self, action: #selector(animateViews), for: .touchUpInside)
    self.resetAnimationsButton.addTarget(self, action: #selector(resetAnimation), for: .touchUpInside)
  }
  
  
  // MARK: - Animations
    
  
  // MARK: Property Animator
  internal func animateViews() {
    
    self.animateDarkBlueViewWithSnapkit()
    self.animateTealViewWithSnapkit()
    self.animateYellowViewWithSnapkit()
    self.animateOrangeViewWithSnapkit()
  }
    internal func resetAnimation() {
        
        let _ = [blueAnimator,
                 yellowAnimator,
                 orangeAnimator,
                 tealAnimator].map { $0.isReversed = true }
            
            //.map{$0.stopAnimation(true)}
        blueAnimator.addCompletion { (position: UIViewAnimatingPosition) in
            switch position {
            case .start: print("just started")
            case .end: print("just ended")
            case .current : print("in progress ")
            }
        }
        
        let _ = [
        darkBlueView,
            tealView,
            yellowView,
            orangeView
            ].map{$0.transform = CGAffineTransform.identity}
        
        configureConstraints()
        darkBlueView.backgroundColor = Colors.darkBlue
    }
    
    internal func animateTealViewWithSnapkit() {
        tealView.snp.remakeConstraints{ (view) in
            view.top.equalTo(darkBlueView.snp.bottom).offset(20.0)
            view.trailing.equalToSuperview().inset(20.0)
            view.size.equalTo(ViewController.squareSize)
        }
//        UIViewPropertyAnimator(duration: 1.0, curve: .easeIn) {
//            //self.darkBlueView.frame = newFrame
//            self.view.layoutIfNeeded()
//            
//            }.startAnimation()
//        
        tealAnimator.addAnimations {
            self.view.layoutIfNeeded()
        }
        tealAnimator.startAnimation()
    }
  
    internal func animateYellowViewWithSnapkit() {
        yellowView.snp.remakeConstraints{ (view) in
            view.top.equalTo(tealView.snp.bottom).offset(20.0)
            view.trailing.equalToSuperview().inset(20.0)
            view.size.equalTo(ViewController.squareSize)
        }
//        UIViewPropertyAnimator(duration: 1.0, curve: .easeOut) {
//            //self.darkBlueView.frame = newFrame
//            self.view.layoutIfNeeded()
//            
//            }.startAnimation()
        yellowAnimator.addAnimations {
            self.view.layoutIfNeeded()
        }
        yellowAnimator.startAnimation()
    }
    
    internal func animateOrangeViewWithSnapkit() {
        orangeView.snp.remakeConstraints{ (view) in
            view.top.equalTo(yellowView.snp.bottom).offset(20.0)
            view.trailing.equalToSuperview().inset(20.0)
            view.size.equalTo(ViewController.squareSize)
        }
//        UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut) {
//            //self.darkBlueView.frame = newFrame
//            self.view.layoutIfNeeded()
//            
//            }.startAnimation()
      
        orangeAnimator.addAnimations {
            self.view.layoutIfNeeded()
            
        }
        orangeAnimator.startAnimation()
    }
    
    
  internal func animateDarkBlueViewWithSnapkit() {
    // this can go in the animator block 
    
    darkBlueView.snp.remakeConstraints{ (view) in
        view.top.equalToSuperview().offset(20.0)
        view.trailing.equalToSuperview().inset(20.0)
        view.size.equalTo(ViewController.squareSize)
    }
    

    
//   // let newFrame = darkBlueView.frame.offsetBy(dx: 100.0, dy: 400.0)
//    UIViewPropertyAnimator(duration: 1.0, curve: .linear) {
//        //self.darkBlueView.frame = newFrame
//        self.view.layoutIfNeeded()
//        self.darkBlueView.backgroundColor = Colors.red
//
//    }.startAnimation()
    blueAnimator.addAnimations {
        self.view.layoutIfNeeded()
    }
    blueAnimator.startAnimation()
    

    
    // This is the same as above
//    let animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear) {
//        self.darkBlueView.frame = newFrame
//    }
//    animator.startAnimation()


}
  
    
  
  // MARK: Frames
  internal func animateDarkBlueViewWithFrames() {
    let newFrame = darkBlueView.frame.offsetBy(dx: 100.0, dy: 640.0)
    UIView.animate(withDuration: 3.0) {
        //the changes you want to creat 
        self.darkBlueView.frame = newFrame
        self.darkBlueView.alpha = 0.5
        self.darkBlueView.backgroundColor = Colors.orange
    }
  }
  
  
  // MARK: - Lazy Inits
  internal lazy var darkBlueView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = Colors.darkBlue
    return view
  }()
    internal lazy var tealView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = Colors.teal
        return view
    }()
    
    internal lazy var yellowView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = Colors.yellow
        return view
    }()
    internal lazy var orangeView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = Colors.orange
        return view
    }()
    
    
  
  internal lazy var animateButton: UIButton = {
    let button = UIButton(type: UIButtonType.roundedRect)
    button.setTitle("Animate", for: .normal)
    //button.addTarget(self, action: #selector("buttonClicked"), for: .touchUpInside)
    return button
  }()
    
    internal lazy var resetAnimationsButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Reset", for: .normal)
        return button
    }()
  
}


