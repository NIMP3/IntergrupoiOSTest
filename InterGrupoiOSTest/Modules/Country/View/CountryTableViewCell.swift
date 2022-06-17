//
//  CountryTableViewCell.swift
//  InterGrupoiOSTest
//
//  Created by Edwin Yovany on 17/06/22.
//

import UIKit

typealias CountryTapHandler = () -> Void

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryShortNameLabel: UILabel!
    @IBOutlet weak var countryPhoneCodeLabel: UILabel!
    
    @IBAction func showMapAction() {
        if let handler = handler { handler() }
    }
    
    var handler: CountryTapHandler?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadData(_ country: Country, _ handler: CountryTapHandler?) {
        self.handler = handler
        
        countryNameLabel.text = country.name
        countryShortNameLabel.text = country.short_name
        countryPhoneCodeLabel.text = String(country.phone_code)
    }
}
