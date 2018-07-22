//
//  ViewController.swift
//  NationMatch
//
//  Created by Tommy Ryanto on 10/7/18.
//  Copyright © 2018 Tommy Ryanto. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var countries: [String] = []

    @IBOutlet var nationPicker: [UIPickerView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request("https://api.printful.com/countries").responseJSON { (response) -> Void in
            if let value = response.result.value {
                let json = JSON(value)
                for i in 0...json["result"].count-1{
                    self.countries.append(json["result"][i]["name"].string!)
                    DispatchQueue.main.async {
                        for i in 0...1{
                            self.nationPicker[i].delegate = self
                            self.nationPicker[i].dataSource = self
                        }
                    }
                }
            }
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return countries[row]
    }

}

