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
    
    //MARK: - Properties
    private let cellId = "SearchTableViewCell"
    //private var searchText:String
    var viewModel = ViewModelSearch()
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        //configureView()
        bind()
    }
    
    func setupUI() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        
        searchBar.delegate = self
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToForecastCityViewController" {
            if let destiny = segue.destination as? ForecastCityViewController {
                if let index = sender as? Int {
                    let value = viewModel.dataSource[index].woeid
                    destiny.woeid = value!
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
            viewModel.getCity(cityString: searchText)
        }
    }
}
