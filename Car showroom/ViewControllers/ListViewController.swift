//
//  ListViewController.swift
//  Car showroom
//
//  Created by Viktor Chernykh on 11/04/2019.
//  Copyright © 2019 Viktor Chernykh. All rights reserved.
//

import SceneKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var cars = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCars()
        setupUI()
    }
    
    func saveCars() {
        // TODO: save the cars
    }
    
    func loadCars() {
        cars = Car.loadSample()
    }
    
    func setupUI() {
        tableView.dataSource = self
    }
}

extension ListViewController {
    // MARK: - Custom Methods
    func configure(_ cell: Cell, with car: Car) {
        guard let scene = SCNScene(named: car.url) else { return }
        
        cell.nameLabel.text = car.name
        cell.starsLabel.text = car.stars
        
        if (car.name == "ship") || (car.name == "Dodge") || (car.name == "ZIS-5B") {
            // retrieve the node
            guard let node = scene.rootNode.childNode(withName: car.name, recursively: true) else { return }
            
            // animate the 3d object
            node.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 2)))
        }
        cell.sceneView.scene = scene
        
        // configure the view
        cell.sceneView.backgroundColor = UIColor.white
    }
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let car = cars[row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        
        configure(cell, with: car)
        return cell
    }
}

// MARK: - Navigation
extension ListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "DetailSegue" else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        let controller = segue.destination as! DetailViewController
        
        controller.car = cars[indexPath.row]
        // deselect curent row
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
