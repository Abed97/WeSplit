//
//  ContentView.swift
//  WeSplit
//
//  Created by Abed Atassi on 2021-09-07.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = ""
    @State private var pplnum = 0
    @State private var tip = 2
    
    let tips = [0, 10, 15, 18, 20]
    
    var totalPerPerson: Double {
        let numOfPeople = Double(pplnum + 2)
        let tipChoice = Double(tips[tip])
        let orderAmt = Double(amount) ?? 0
        
        let totalPP = (orderAmt + (tipChoice * orderAmt / 100)) / numOfPeople
        return totalPP
    }
    
    var totalWithTip: Double {

        let tipChoice = Double(tips[tip])
        let orderAmt = Double(amount) ?? 0
        
        let total = orderAmt + (tipChoice * orderAmt / 100)
        return total
    }
    
    var isTipZero: Bool {
        
        var isZero = false
        if tips[tip] == 0 {
            isZero =  true
        } else {
            isZero = false
        }
        return isZero
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter the amount and number of people")) {
                    TextField("Amount", text: $amount).keyboardType(.decimalPad)
                    
                    Picker("Number of People", selection: $pplnum) {
                        ForEach(2 ..< 40) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("Choose the tip percentage")) {
                    Picker("Tip Percentage", selection: $tip) {
                        ForEach(0 ..< tips.count) {
                            Text("\(self.tips[$0])%")
                            
                        }
                        
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total Amount with tip")) {
                    Text("\(totalWithTip, specifier: "%.2f")$")
                        .foregroundColor(isTipZero ? .red : .primary)
                        
                }
                
                
                Section(header: Text("Amount per person")) {
                    Text("\(totalPerPerson, specifier: "%.2f")$") 
                }
            }.navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()

        }
    }
}
