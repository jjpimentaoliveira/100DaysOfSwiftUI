//
//  ContentView.swift
//  WeSplit
//
//  Created by José João Pimenta Oliveira on 31/12/2022.
//

import SwiftUI

struct ContentView: View {

    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool

    let currencyIdentifier = Locale.current.currency?.identifier ?? "EUR"

    let tipPercentages = [10, 15, 20, 25, 0]

    var totalAmount: Double {
        let tipValue = (checkAmount / 100) * Double(tipPercentage)
        return checkAmount + tipValue
    }

    var totalPerPerson: Double {

        // calculate the total per person
        let peopleCount = Double(numberOfPeople) + 2
        let tipValue = (checkAmount / 100) * Double(tipPercentage)
        let grandTotal = checkAmount + tipValue

        return grandTotal / peopleCount
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyIdentifier))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }

                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }

                Section {
                    Text(totalAmount, format: .currency(code: currencyIdentifier))
                } header: {
                    Text("Total amount")
                }

                Section {
                    Text(totalPerPerson, format: .currency(code: currencyIdentifier))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
