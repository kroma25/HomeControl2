//
//  ModuleComfort.swift
//  HomeControl
//
//  Created by Przemyslaw Kromólski on 27/05/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import UIKit

class ModuleComfort: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func buttonMC(_ sender: Any) {
        
        //ManagementModes().labelChange(tempMode: "Wybrany tryb: Komfortowy")
        Management2().writeThermostat(choice: "Komfort", temp: 21)
        Management2().lightStatus(status: "Komfort",bright: 70)
        Management2().allowManualChangeTemp()
        Management2().allowManualChangeBlinds()
        Management2().presenceSensor(time: 20)
        Management2().statusWindowOpen()
    }
    
}


//Jest podstawowym trybem aplikacja.
//Umożliwa on dowolną zmianę temperatury, na każdym urządzeniu z osoba.
//Termostat w budynku jest domyślnie ustawiony na 21C, użytkownik może za pomocą aplikacji lub ręcznie zmienić jego temperature jak i głowicy temostatycznej.
//Żródła światła maja wstępnie ustawione natężenie na 70%, lecz użytkowni tak jak wyżej może to skorygować.
//Obsługa rolet jest aktywna i można dowolnie je kontrolować.
//Czujnik obecności jest włączony w pomieszczeniach przechodniach ale czas wyłączenia światła wynosi 20 min jeśli nie ma ruchu.
//Czujniki otwartych okien są uruchomione, działają na zasadzie, że  szybkiego obniżenia się temperatury w pokoju powoduję wyłącznie się grzania danego grzejnika.
