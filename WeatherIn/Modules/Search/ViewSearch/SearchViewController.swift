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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    var viewModel = ViewModelSearch()
    private let cellId = "SearchTableViewCell"
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bind()
    }
    
    func setupUI() {
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    private func bind() {
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToForecastCityViewController" {
            if let destiny = segue.destination as? ForecastCityViewController {
                if let index = sender as? Int {
                    let value = viewModel.dataSource[index].woeid
                    let value2 = viewModel.dataSource[index].title
                    destiny.woeid = value!
                    destiny.city = value2!
                }
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

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToForecastCityViewController", sender: indexPath.row)
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let searchText = searchBar.text!
        if (searchText != "") {
            //activityIndicator.hidesWhenStopped = false
            activityIndicator.startAnimating()
            viewModel.getCity(cityString: searchText)
        }
    }
}
