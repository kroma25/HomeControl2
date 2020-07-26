//
//  Data.swift
//  HomeControl
//
//  Created by Przemyslaw Kromólski on 04/06/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import Foundation

class DataBuffor {

    struct Matrix {
        
        let rows: Int, columns: Int
        var grid: [Double]
        init(rows: Int, columns: Int) {
            self.rows = rows
            self.columns = columns
            grid = Array(repeating: 0.0, count: rows * columns)
        }
        func indexIsValid(row: Int, column: Int) -> Bool {
            return row >= 0 && row < rows && column >= 0 && column < columns
        }
        subscript(row: Int, column: Int) -> Double {
            get {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                return grid[(row * columns) + column]
            }
            set {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                grid[(row * columns) + column] = newValue
            }
        }
    }


    func start() {
        //inicajlizacja tabeli
        //Pomieszczenie nr1
        
        //poniedziałek-czwartek = 0,1,2,3
        for i in 0...3 {
            MyVariables.room1[7,i]=0.07
            MyVariables.room1[16,i]=0.07
            MyVariables.room1[17,i]=0.07
            MyVariables.room1[18,i]=0.07
            MyVariables.room1[19,i]=0.07
            MyVariables.room1[20,i]=0.07
        }
        //piatek = 4
        MyVariables.room1[7,4]=0.07
        MyVariables.room1[16,4]=0.07
        MyVariables.room1[17,4]=0.07
        MyVariables.room1[18,4]=0.07
        MyVariables.room1[19,4]=0.07
        MyVariables.room1[20,4]=0.07
        MyVariables.room1[21,4]=0.07
        //sobota = 5
        MyVariables.room1[7,5]=0.07
        MyVariables.room1[8,5]=0.07
        MyVariables.room1[9,5]=0.07
        MyVariables.room1[10,5]=0.07
        MyVariables.room1[11,5]=0.07
        MyVariables.room1[12,5]=0.07
        MyVariables.room1[13,5]=0.07
        MyVariables.room1[14,5]=0.07
        MyVariables.room1[16,5]=0.07
        MyVariables.room1[18,5]=0.07
        MyVariables.room1[19,5]=0.07
        MyVariables.room1[20,5]=0.07
        MyVariables.room1[21,5]=0.07
        MyVariables.room1[22,5]=0.07
        //niedziela = 6
        MyVariables.room1[7,6]=0.07
        MyVariables.room1[8,6]=0.07
        MyVariables.room1[9,6]=0.07
        MyVariables.room1[10,6]=0.07
        MyVariables.room1[11,6]=0.07
        MyVariables.room1[12,6]=0.07
        MyVariables.room1[13,6]=0.07
        MyVariables.room1[14,6]=0.07
        MyVariables.room1[16,6]=0.07
        MyVariables.room1[18,6]=0.07
        MyVariables.room1[19,6]=0.07
        MyVariables.room1[20,6]=0.07
        
        //Pomiesczenie nr 2
        
        //poniedziałek-czwartek = 0,1,2,3
        for i in 0...3 {
            MyVariables.room2[6,i]=0.07
            MyVariables.room2[16,i]=0.07
            MyVariables.room2[18,i]=0.07
            MyVariables.room2[21,i]=0.07
        }
        //piatek=4
        MyVariables.room2[6,4]=0.07
        MyVariables.room2[16,4]=0.07
        MyVariables.room2[22,4]=0.07
        //sobota = 5
        MyVariables.room2[7,5]=0.07
        MyVariables.room2[8,5]=0.07
        MyVariables.room2[12,5]=0.07
        MyVariables.room2[22,5]=0.07
        //niedziela = 6
        MyVariables.room2[7,6]=0.07
        MyVariables.room2[8,6]=0.07
        MyVariables.room2[12,6]=0.07
        MyVariables.room2[21,6]=0.07
        
        //Pomiesczenie nr 3
        //var room3 = Matrix.init(rows: 24, columns: 7)
        //poniedziałek-czwartek = 0,1,2,3
        for i in 0...3 {
            MyVariables.room3[7,i]=0.07
            MyVariables.room3[16,i]=0.07
            MyVariables.room3[21,i]=0.07
        }
        //piatek=4
        MyVariables.room3[7,4]=0.07
        MyVariables.room3[16,4]=0.07
        MyVariables.room3[22,4]=0.07
        //sobota = 5
        MyVariables.room3[7,5]=0.07
        MyVariables.room3[8,5]=0.07
        MyVariables.room3[22,5]=0.07
        //niedziela = 6
        MyVariables.room3[7,6]=0.07
        MyVariables.room3[8,6]=0.07
        MyVariables.room3[21,6]=0.07
        
        //Pomiesczenie nr 4
        //var room4 = Matrix.init(rows: 24, columns: 7)
        //poniedziałek-czwartek = 0,1,2,3
        for i in 0...3 {
            MyVariables.room4[7,i]=0.07
            MyVariables.room4[16,i]=0.07
        }
        //piatek=4
        MyVariables.room4[7,4]=0.07
        MyVariables.room4[16,4]=0.07
        //sobota = 5
        MyVariables.room4[7,5]=0.07
        //niedziela = 6
        MyVariables.room4[7,6]=0.07
        MyVariables.room4[11,6]=0.07
        
        //Pomiesczenie nr 5
        //var room5 = Matrix.init(rows: 24, columns: 7)
        //poniedziałek-czwartek = 0,1,2,3
        for i in 0...3 {
            MyVariables.room5[6,i]=0.07
            MyVariables.room5[21,i]=0.07
            MyVariables.room5[22,i]=0.07
        }
        //piatek=4
        MyVariables.room5[6,4]=0.07
        MyVariables.room5[22,4]=0.07
        MyVariables.room5[23,4]=0.07
        //sobota = 5
        MyVariables.room5[7,5]=0.07
        MyVariables.room5[15,5]=0.07
        MyVariables.room5[17,5]=0.07
        MyVariables.room5[22,5]=0.07
        MyVariables.room5[23,5]=0.07
        //niedziela = 6
        MyVariables.room5[7,6]=0.07
        MyVariables.room5[15,6]=0.07
        MyVariables.room5[17,6]=0.07
        MyVariables.room5[21,6]=0.07
        MyVariables.room5[22,6]=0.07
        
        //Pomiesczenie nr 6
        //var room6 = Matrix.init(rows: 24, columns: 7)
        //poniedziałek-czwartek = 0,1,2,3
        for i in 0...3 {
            MyVariables.room6[6,i]=0.07
            MyVariables.room6[19,i]=0.07
            MyVariables.room6[20,i]=0.07
            MyVariables.room6[21,i]=0.07
            MyVariables.room6[22,i]=0.07
        }
        //piatek=4
        MyVariables.room6[6,4]=0.07
        MyVariables.room6[20,4]=0.07
        MyVariables.room6[21,4]=0.07
        MyVariables.room6[22,4]=0.07
        MyVariables.room6[23,4]=0.07
        //sobota = 5
        MyVariables.room6[8,5]=0.07
        MyVariables.room6[9,5]=0.07
        MyVariables.room6[10,5]=0.07
        MyVariables.room6[11,5]=0.07
        MyVariables.room6[15,5]=0.07
        MyVariables.room6[16,5]=0.07
        MyVariables.room6[17,5]=0.07
        MyVariables.room6[22,5]=0.07
        MyVariables.room6[23,5]=0.07
        //niedziela = 6
        MyVariables.room6[8,6]=0.07
        MyVariables.room6[9,6]=0.07
        MyVariables.room6[10,6]=0.07
        MyVariables.room6[11,6]=0.07
        MyVariables.room6[15,6]=0.07
        MyVariables.room6[16,6]=0.07
        MyVariables.room6[17,6]=0.07
        MyVariables.room6[21,6]=0.07
        MyVariables.room6[22,6]=0.07

    }
}
    



