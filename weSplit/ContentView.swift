//
//  ContentView.swift
//  weSplit
//
//  Created by Vinicius Wessner on 21/02/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 1
    @State private var tipPercentage = 20
    @FocusState private var amounIsFocus: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerson:Double {
        let peopleCount = Double(numberOfPeople + 1)
        let tipSelection = Double(tipPercentage)
        
        let tipvalue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipvalue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    // valor total mais gorgeta
    var valorTotalCompra: Double {
        let valorcompra = Double(checkAmount)
        let valorgorgeta = Double(tipPercentage)
        
        let valortotal = valorcompra + valorgorgeta
        
        return valortotal
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Valor da Comanda"){
                    TextField("Valor total", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "R$"))
                        .keyboardType(.decimalPad)
                        .focused($amounIsFocus)
                    
                }
                
                Section("Porcentagem de gorjeta"){
                    Picker("tippercentagem ao garcom", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Valor total da comanda:"){
                    Text(valorTotalCompra, format: .currency(code: Locale.current.currency?.identifier ?? "R$"))
                }
                
                Section("Valor por pessoa"){
                    Picker("Numero de pessoas", selection: $numberOfPeople) {
                        ForEach(1..<30) {
                            Text("\($0) Pessoas")
                        }
                    }
                    Text(totalPerson, format: .currency(code: Locale.current.currency?.identifier ?? "R$"))
                }
                

            }
            .navigationTitle("weSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if amounIsFocus {
                    Button("Fechar") {
                        amounIsFocus = false
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
