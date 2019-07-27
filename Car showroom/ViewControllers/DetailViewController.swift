//
//  DetailViewController.swift
//  Car showroom
//
//  Created by Viktor Chernykh on 11/04/2019.
//  Copyright © 2019 Viktor Chernykh. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class DetailViewController: UIViewController {
    @IBOutlet weak var scnView: SCNView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var car: Car!
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
// MARK: - UIViewController Methods
extension DetailViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateUI(with: view.frame.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateUI(with: size)
    }
}

// MARK: - Custom Methods
extension DetailViewController {
    // change axis in stack view
    func updateUI(with size: CGSize) {
        stackView.axis = size.width < size.height ? .vertical : .horizontal
    }
    
    func setupUI() {
        
        guard let car = car else { return }
        
        // create a new scene
        let scene = SCNScene(named: car.url)!
        
        // retrieve the ship node
        let ship = scene.rootNode.childNode(withName: car.name, recursively: true)!
        
        // animate the 3d object
        ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 5)))
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        //scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.white
        
        nameLabel.text = car.characteristics
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {

        // retrieve the SCNView
        //guard self.view is SCNView else { return }
        guard let scnView = self.view as? SCNView else { return }

        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            let material = result.node.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.red
            
            SCNTransaction.commit()
        }
    }
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return .allButUpsideDown
//        } else {
//            return .all
//        }
//    }

}
