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
    var viewModel = ViewModelSearch()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureView()
        bind()
    }
    
    func setupUI() {
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    private func configureView() {
        viewModel.getCity(cityString: "lon")
    }
    
    private func bind() {
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)!
        let object = viewModel.dataSource[indexPath.row]
        
        if let cell = cell as? SearchTableViewCell {

            cell.titleLabel.text = object.title
            cell.locationTypeLabel.text = object.location_type
        }
        
        return cell
    }
}
