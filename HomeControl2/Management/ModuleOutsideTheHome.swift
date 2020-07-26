//
//  ModuleOutsideTheHome.swift
//  HomeControl
//
//  Created by Przemyslaw Kromólski on 26/05/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import UIKit


class ModuleOutsideTheHome: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
        
//    @IBAction func buttonMOTH1(_ sender: Any) {
//        //ManagementModes().labelModeChoice.text! = "Wybrany tryb: Poza domem"
       
        //        //ManagementModes().labelChange(tempMode: "Wybrany tryb: Poza domem")
      
        //        print(ManagementModes().labelModeChoice.text)
//        //do usunie ponizej //
//        Management2().writeThermostat(choice: "Off All", temp: 16)
//        Management2().lightStatus(status: "Off All",bright: 0)
//        Management2().guardAllOff()
//        Management2().blockManual()
//        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)
        {
            print("Ogrzewanie centralne wyłączone")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0)
        {
            print("Światło 1: OFF")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0)
        {
            print("Światło 2: OFF")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0)
        {
            print("Światło 3: OFF")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0)
        {
            print("Światło 4: OFF")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0)
        {
            print("Światło 5: OFF")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0)
        {
            print("Światło 6: OFF")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 9.0)
        {
            print("Światło 7: OFF")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0)
        {
            print("Światło 8: OFF")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 11.0)
        {
            print("Grzejnik 1: OFF")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 12.0)
        {
            print("Grzejnik 2: OFF")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 13.0)
        {
            print("Grzejnik 3: OFF")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 14.0)
        {
            print("Grzejnik 4: OFF")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 15.0)
        {
            print("Grzejnik 5: OFF")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 16.0)
        {
            print("Grzejnik 6: OFF")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 17.0)
        {
            print("Grzejnik 7: OFF")
        }
        
        
        
    }
}
class Management2: UIViewController {
    func writeThermostat(choice:String,temp:Double) {}
    func lightStatus(status:String,bright:Double) {}
    func guardAllOff(){
    //guardAllOff działa na zasadzie sprawdzania co 10 minut czy wszystkie powyższe użadzanie są wyłączone
    }
    func allowManualChangeTemp(){}
    func allowManualChangeBlinds(){}
    func presenceSensor(time: Int){}
    func statusWindowOpen(){}
    func blockManual(){
    //blockManual powoduję wsyłanie do urządzeń informacji o blokadzie obsługi fizycznej, użytkownik może spróbować włączyć,zmienić jaką wartośc na urządzeniach ale wartośc ta nie zostanie przyejęta.
    }
    func windowBlindsAuto(){}
    func compareTemp(){
        
    }
}
