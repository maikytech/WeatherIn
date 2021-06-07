//
//  ForecastCityViewController.swift
//  WeatherIn
//
//  Created by Maiqui Cedeño on 3/06/21.
//

import UIKit

class ForecastCityViewController: UIViewController {
    
    //MARK: - IBOulets
    @IBOutlet weak var forecastImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    let formatter = DateFormatter()
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
        dayOfWeek()
    }
    
    private func setupUI() {
        
        title = city
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    private func configureView() {
        
        activityIndicator.startAnimating()
        viewModel.getForecast(woeid: woeid)
    }
    
    private func bind() {
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func dayOfWeek() {
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.dateFormat = "EEEE"
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
            
            if indexPath.row == 0 {
                
                let temperature = Int(round(object.max_temp!))
                self.temperatureLabel.text = String(temperature) + "º"
                //self.temperatureLabel.text = String(object.max_temp!) + "º"
                self.humidityLabel.text = String(object.humidity!) + "%"
                self.forecastImageView.image = UIImage(named: object.weather_state_name!)
            }
            
            let temperature  = Int(round(object.max_temp!))
            cell.tempMaxLabel.text = String(temperature) + "º"
            
            cell.humidityLabel.text = String(object.humidity!) + "%"
            cell.dayLabel.text = formatter.string(from: object.applicable_date!)
            
            if let imageForecast = object.weather_state_name {
                cell.forecastImageView.image = UIImage(named: imageForecast)
            }
            
    
            self.activityIndicator.stopAnimating()
        }
        return cell
    }
}
