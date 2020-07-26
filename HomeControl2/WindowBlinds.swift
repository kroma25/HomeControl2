//
//  WindowBlinds.swift
//  HomeControl
//
//  Created by Przemyslaw Kromólski on 21/05/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import UIKit

class WindowBlinds: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var labelDegree: UITextView!
    @IBOutlet var picker: UIPickerView!
    var pickerData: [String] = [String]()
    var buttonPush = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        //wyswuietelnie labla 0 stopni
        let x:Int = MyVariables.angle["Pomieszczenie nr 1"] ?? 0
        labelDegree.text = String(describing: x) as String
        //
        pickerData = ["Pomieszczenie nr 1", "Pomieszczenie nr 2", "Pomieszczenie nr 3","Pomieszczenie nr 4", "Pomieszczenie nr 5","Pomieszczenie nr 6"]
    }
    
    @IBAction func buttonUp(_ sender: Any) {
        activeLedShelly()
    }
    @IBAction func buttonUpRelase(_ sender: Any) {
        inactiveLedShelly()
    }
    @IBAction func buttonStop(_ sender: Any) {
        activeLedShelly()
    }
    @IBAction func buttonStopRelase(_ sender: Any) {
        inactiveLedShelly()
    }
    @IBAction func buttonDown(_ sender: Any) {
        activeLedShelly()
    }
    @IBAction func buttonDownRelase(_ sender: Any) {
        inactiveLedShelly()
    }
    @IBAction func buttonPlusRelase(_ sender: Any) {
        inactiveLedShelly()
    }
    @IBAction func buttonPlus(_ sender: Any) {
        activeLedShelly()
        if var tempa = Int(labelDegree.text!){
            if tempa < 180{ // zabezpieczenie przed przekręceniem temperatury
                tempa+=1
                labelDegree.text = String(tempa)
                MyVariables.angle["\(MyVariables.stateWindowBlinds)"] = tempa
            }
            
        } else {
            print("Not a valid number: \(labelDegree.text!)")
        }
    }
    @IBAction func buttonMinusRelase(_ sender: Any) {
        inactiveLedShelly()
    }
    @IBAction func buttonMinus(_ sender: Any) {
        activeLedShelly()
        if var tempa = Int(labelDegree.text!){
            if tempa > -180{ // zabezpieczenie przed przekręceniem temperatury
                tempa-=1
                labelDegree.text = String(tempa)
                MyVariables.angle["\(MyVariables.stateWindowBlinds)"] = tempa
            }
            
        } else {
            print("Not a valid number: \(labelDegree.text!)")
        }
    }
    
 
    
    func inactiveLedShelly(){
        //button1.setTitle("Wyłącz", for: UIControl.State.normal)
        if let url = URL(string: "http://192.168.0.22/relay/0?turn=off") {
            do {
                let contents = try String(contentsOf: url)
                //print(contents) //informacje co jest odbierane
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
    }
    func activeLedShelly(){
        //button1.setTitle("Wyłącz", for: UIControl.State.normal)
        if let url = URL(string: "http://192.168.0.22/relay/0?turn=on") {
            do {
                let contents = try String(contentsOf: url)
                //print(contents) //informacje co jest odbierane
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
    }
    
    //pickerView do usunicia potem
    func numberOfComponents(in picker: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        print(pickerData[row])
        
        labelDegree.text = "\(String(describing: MyVariables.angle[pickerData[row]] ?? 0))"
        MyVariables.stateWindowBlinds = "\(pickerData[row])"
        // tutaj zmienamy wyglad statystk
        
        
    }
    //pickerView koniec usuniecia
}
