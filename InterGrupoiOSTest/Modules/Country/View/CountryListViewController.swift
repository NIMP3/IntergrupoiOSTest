//
//  CountryListViewController.swift
//  InterGrupoiOSTest
//
//  Created by Edwin Yovany on 17/06/22.
//

import UIKit

class CountryListViewController: UIViewController {

    @IBOutlet weak var countriesTableView: UITableView!
    
    var presenter: ViewToPresenterCountryProtocol?
    var countries: [Country]?
    private let cellIdentifier = "countryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CountryRouter.createCountryModule(self)
        presenter?.getCountries()
    }
    
    private func setupUI() {
        countriesTableView.dataSource = self
        countriesTableView.delegate = self
    }
}

extension CountryListViewController: PresenterToViewCountryProtocol {
    func showCountries(countries: [Country]) {
        self.countries = countries
        countriesTableView.reloadData()
    }
    
    func showProgressBar() {}
    func hideProgressBar() {}
    func showMessage(message: Message) {}
}

extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = countriesTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CountryTableViewCell else {
            return CountryTableViewCell()
        }
        
        if let country = countries?[indexPath.row] {
            cell.countryNameLabel.text = country.name
        }
        
        return cell
    }
    
    
}


