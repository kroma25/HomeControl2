//
//  Harmonogram.swift
//  HomeControl
//
//  Created by Przemyslaw Kromólski on 19/05/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import UIKit

class Harmonogram: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
        //Jak dzila roll(picker)
        //https://codewithchris.com/uipickerview-example/
    //https://www.ioscreator.com/tutorials/picker-view-ios-tutorial-ios10
    
    //Jak działa tableView

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var buttonWstaw: UIButton!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        
        pickerData = ["Tryb ekonomiczny", "Tryb konfortowy", "Tryb weekendowy"]
        //pickerData = ["Blebox dimmerBox", "Shelly 1PM"]
    }
    
    
    func numberOfComponents(in picker: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
