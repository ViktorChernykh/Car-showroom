//
//  Cell.swift
//  Car showroom
//
//  Created by Viktor on 11/04/2019.
//  Copyright © 2019 Viktor Chernykh. All rights reserved.
//

import SceneKit

class Cell: UITableViewCell {
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Custom Methods
    func configure(with car: Car) {
        nameLabel.text = car.name
        starsLabel.text = car.stars
        
        guard let scene = SCNScene(named: car.url) else { return }
        
//        let rootNode = scene.rootNode.childNodes[0]
//        rootNode.name = car.name
        
        if car.name == "ship" {
            // retrieve the ship node
            guard let node = scene.rootNode.childNode(withName: car.name, recursively: true) else { return }
            
            // animate the 3d object
            node.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 2)))
        }
        
        sceneView.scene = scene
        
        // configure the view
        sceneView.backgroundColor = UIColor.white
        
    }

}
