//
//  DetailViewController.swift
//  Car showroom
//
//  Created by Viktor on 11/04/2019.
//  Copyright © 2019 Viktor Chernykh. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class DetailViewController: UIViewController {
    @IBOutlet weak var scnView: SCNView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var ratingLabel: UILabel!
//    @IBOutlet weak var notesLabel: UILabel!
//    @IBOutlet weak var timestampLabel: UILabel!
    
    var car: Car!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene(named: car.url)!
        
        if car.name == "ship" {
            // retrieve the ship node
            let ship = scene.rootNode.childNode(withName: car.name, recursively: true)!
            
            // animate the 3d object
            ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 5)))
        }
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        //scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.white
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {

        // retrieve the SCNView
        if self.view is SCNView {
            let scnView = self.view as! SCNView

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
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

}

// MARK: - UIViewController Methods
extension DetailViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateUI(with: size)
    }
}

// MARK: - Custom Methods
extension DetailViewController {
    func setupUI() {
        guard let car = car else { return }

        nameLabel.text = car.name
//                timestampLabel.text = String(car.timestamp)
//                ratingLabel.text = car.stars
//                notesLabel.text = car.characteristics
        
        updateUI(with: view.frame.size)
    }
    
    func updateUI(with size: CGSize) {
        stackView.axis = size.width < size.height ? .vertical : .horizontal
    }
}
