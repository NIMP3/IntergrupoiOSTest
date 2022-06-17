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
    var countries: [Country] = []
    var filteredList: [Country] = []
    private let cellIdentifier = "countryCell"
    private let searchController = UISearchController()
    
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
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
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

extension CountryListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filteredList = countries.compactMap({ $0 }).filter ({
            $0.name.lowercased().contains(text.lowercased())})
        countriesTableView.reloadData()
    }
}

extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? filteredList.count : countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = countriesTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CountryTableViewCell else {
            return CountryTableViewCell()
        }
        
        if (searchController.isActive ? (!filteredList.isEmpty) : (!countries.isEmpty)) {
            let country = searchController.isActive ? filteredList[indexPath.row] : countries[indexPath.row]
            cell.loadData(country) {
                self.presenter?.router?.pushToMap(on: self, country.name)
            }
        }

        return cell
    }
}

extension CountryListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap",
            let mapViewController = segue.destination as? CountryMapViewController,
            let countryName = sender as? String {
            
            mapViewController.countryName = countryName
        }
    }
}
