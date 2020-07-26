//
//  ModuleEconomic.swift
//  HomeControl
//
//  Created by Przemyslaw Kromólski on 27/05/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import UIKit

class ModuleEconomic: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func buttonME(_ sender: UIButton) {
        Management2().windowBlindsAuto()
        Management2().statusWindowOpen()
        Management2().lightStatus(status: "Ekonomiczny",bright: 50)
        Management2().presenceSensor(time: 3)
        Management2().blockManual()
        Management2().writeThermostat(choice: "Ekonomiczny", temp: 18)
        Management2().compareTemp()
    }
}

//Uruchumienie tego trybu powoduje ,że rolety zewnętrzne korygują temperaturze wewnętrzną
//budynku poprzez nasłonecznia go bardziej gdy słońce świeci w porze dnia, a gdy czujnik
//temperatury sprawdzi że tendecja tempeatury w pomieszczeniu jest rosnacą zmniejszy ilość
//padanych promieni słońca poprzez zmniejsznie nasłonecznie pokoju.

//Wkrywanie otwartych okien działa na zasadzie, że głowica termostatyczny zamontowana
//na  grzejniku wykryje nagły spadek temperatury i wyłączy dopływ ciepłej wody.

//Tryb ustawia maksymalne natężenie światła w wszyskich pomiesczeniach do 50%,
//co daje taki efekt ,że jesli użtykownik spróbuje ręcznie zwiększyć natężenie
//światła urządzanie odrzuci jego próbę i pozostawi 50%.


//Hol i pomieszczenia przechodnie wyłączają automatycznie światło po 3 minutach
//jeśli nie wykryją ruchu licznik jest zerowany po każdym wykryciu ruchu.

//Dane z czujnika zewnętrznego są porównywane z temperaturą wewnątrz,
//jeśli jest duża różnica temperatur, to obniżenie o 1 stopień temperatury
//wewnątrz pozwoli na zwiększyć oszczędności na ogrzewaniu.

//Gdy uruchomiony jest ten tryb obsługa manualna jest wyłączona nie ma możliwość na urządzeniach zmienić temperatury.
