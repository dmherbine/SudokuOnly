//
//  PopAnimator.swift
//  Sudoku
//
//  Created by dave herbine on 4/24/15.
//  Copyright (c) 2015 dave herbine. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {

    fileprivate var presenting = false
    var popWittyMessage: String? = nil
    var popReturnAction: String? = nil
    var gameVC: CVController? = nil
    
    // MARK: UIViewControllerAnimatedTransitioning protocol methods
    
    // animate a change from one viewcontroller to another
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        var damping: CGFloat = 0.5      // init for presenting
        var velocity: CGFloat = 0.8     // init for presenting

        // get reference to our fromView, toView and the container view that we should perform the transition in
        let container = transitionContext.containerView
        
        // create a tuple of our screens
        let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!, transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!)
        
        // assign a reference to the view controller from the tuple
        // remember that our ViewController will alternate between the from and to view controller depending if we're presenting or dismissing
        let popViewController = !self.presenting ? screens.from as! PopViewController : screens.to as! PopViewController
        
        let popView = popViewController.view
        
        // prepare items to slide in and appropriate effect
        if (self.presenting){
            self.offStageVC(popViewController)
            damping = 0.5
            velocity = 0.5
        } else {
            damping = 0.5
            velocity = 0.8
        }
        
        // add the view to our view controller
        container.addSubview(popView!)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        // perform the animation!
        UIView.animate(withDuration: duration, delay: 0.5, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: UIViewAnimationOptions(), animations: {    // UIViewAnimationOptions.TransitionNone was nil
                if (self.presenting) {
                    self.onStageVC(popViewController) // onstage items: slide in
                } else {
                    self.offStageVC(popViewController) // offstage items: slide out
                }
            }, completion: { finished in
                
                // tell our transitionContext object that we've finished animating
                transitionContext.completeTransition(true)
                
                // bug: we have to manually add our 'to view' back http://openradar.appspot.com/radar?id=5320103646199808
                UIApplication.shared.keyWindow!.addSubview(screens.to.view)
                
        })
        
    }
    
    func offStage(_ amount: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(translationX: amount, y: 0)
    }
    
    func offStageVC(_ popViewController: PopViewController){
        
        popViewController.view.alpha = 0.7     // setup paramaters for 2D transitions for animations
        let topRowOffset :CGFloat = 200
        
        popViewController.wittyMessage.transform = self.offStage(-topRowOffset)
        popViewController.saveAsFav.transform = self.offStage(topRowOffset)
        popViewController.playAnother.transform = self.offStage(-topRowOffset)
    }
    
    func onStageVC(_ popViewController: PopViewController){
        
        // prepare menu to fade in
        popViewController.view.alpha = 0.8
        
        if popWittyMessage != nil {
            popViewController.wittyMessage.text = popWittyMessage!
        }
        popViewController.wittyMessage.transform = CGAffineTransform.identity
        popViewController.playAnother.transform = CGAffineTransform.identity
        popViewController.saveAsFav.transform = CGAffineTransform.identity
        
    }
    
    // Required for protocol: return how many seconds the transiton animation will take
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    // MARK: UIViewControllerTransitioningDelegate protocol methods
    
    // return the animataor when presenting a viewcontroller
    // rememeber that an animator (or animation controller) is any object that adheres to the UIViewControllerAnimatedTransitioning protocol
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    // return the animator used when dismissing from a viewcontroller
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}
