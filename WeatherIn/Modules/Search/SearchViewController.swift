//
//  SearchViewController.swift
//  WeatherIn
//
//  Created by Maiqui Cedeño on 2/06/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    private let cellId = "SearchTableViewCell"
    private var dataSource = [City]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getCity()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tableView.reloadData()
        }
    }
    
    func setupUI() {
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    func getCity() {
        
        NetworkingProvider.shared.getCity(cityString: "san") { (city) in
            self.dataSource = city
            print(self.dataSource)
            
        } failure: { (error) in
            print(error.debugDescription)
        }
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let cell = cell as? SearchTableViewCell {
            cell.titleLabel.text = dataSource[indexPath.row].title
            cell.locationTypeLabel.text = dataSource[indexPath.row].location_type
        }
        
        return cell
    }
}
