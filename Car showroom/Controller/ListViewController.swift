//
//  ListViewController.swift
//  Car showroom
//
//  Created by Viktor on 11/04/2019.
//  Copyright © 2019 Viktor Chernykh. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var cars = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCars()
        setupUI()
    }
    
    func saveCars() {
        // TODO: save the meals
    }
    
    func loadCars() {
        cars = Car.loadSample()
    }
    
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
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
        
        cell.configure(with: car)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: - Navigation
extension ListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "DetailSegue" else { return }
        
        let controller = segue.destination as! DetailViewController
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        controller.car = cars[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
