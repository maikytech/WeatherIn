//
//  ForecastCityViewController.swift
//  WeatherIn
//
//  Created by Maiqui Cedeño on 3/06/21.
//

import UIKit

class ForecastCityViewController: UIViewController {
    
    //MARK: - IBOulets
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var forecastImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    var woeid:Int = 0
    var city:String = "No pasaron los datos"
    var dataSource:[consolidatedWeather]?
    var viewModel = ViewModelForecast()
    private let cellId = "ForecastTableViewCell"

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("La nueva city es \(city)")
        
        setupUI()
        configureView()
        bind()
    }
    
    func setupUI() {
         
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        
        cityLabel.text = city
        
    }
    
    private func configureView() {
        viewModel.getForecast(woeid: woeid)
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
extension ForecastCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)!
        let object = viewModel.dataSource[indexPath.row]
        
        if let cell = cell as? ForecastTableViewCell {
                        
            cell.tempMaxLabel.text = String(object.max_temp!) + "º"
            cell.humidityLabel.text = String(object.humidity!) + "%"
            
        }
        
        return cell
    }
}
