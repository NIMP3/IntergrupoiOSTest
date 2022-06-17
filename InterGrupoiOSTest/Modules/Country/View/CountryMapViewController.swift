//
//  CountryMapViewController.swift
//  InterGrupoiOSTest
//
//  Created by Edwin Yovany on 17/06/22.
//

import UIKit
import MapKit

class CountryMapViewController: UIViewController {

    @IBOutlet weak var mapContainer: UIView!
    
    var countryName: String?
    private var map: MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupMap()
    }

    private func setupMap() {
        map = MKMapView(frame:  mapContainer.bounds)
        mapContainer.addSubview(map ?? UIView())
        if let countryName = countryName { searchByName(countryName) }
    }

    private func searchByName(_ name: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = name
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            self.map?.setRegion(response.boundingRegion, animated: true)
        }
    }
}
