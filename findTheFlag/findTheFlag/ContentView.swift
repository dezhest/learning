//
//  ContentView.swift
//  FindTheFlag
//
//  Created by Денис Жестерев on 29.08.2022.
//

import SwiftUI

struct ContentView: View {
    
   @State private var countriesUpp = ["ARGENTINA", "BANGLADESH", "BRAZIL", "CANADA", "GERMANY", "GREECE", "RUSSIA", "SWEDEN", "UK", "USA"].shuffled()
     
     
    func lower () -> [String]{
         var b = [String]()
         for i in countriesUpp {
             b.append(i.lowercased().capitalized)
         }
         return b
     }
 var countries: [String] = []
    init() {
        countries = lower()
    }
    
    @State private var choice = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .yellow]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Выбери флаг")
                        .font(.largeTitle)
                        .font(.headline)
                    Text(countriesUpp[choice])
                        .fontWeight(.black)
                        .font(.largeTitle)
                }
                ForEach (0..<3) { number in
                    Button(action:{
                        self.flagTapped(number)
                        self.showingScore = true
                    })
                    {
                        Image(self.countriesUpp[number].lowercased())
                            .renderingMode(.original)
                            .frame(width: 250, height: 130)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1)) // рамка вокруг шириной 1
                            .shadow(color: .black, radius: 5)
                    }
                }
                Text("Общий счет: \(score)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Общий счет: \(score)"), dismissButton: .default(Text("Продолжить")){
                self.askQuestion()})
            }
        }
        func askQuestion() {
            countriesUpp.shuffle()
            choice = Int.random(in: (0..<2)) // после алерта делаем шафл
        }
    func flagTapped(_ number: Int) {
        if number == choice {
            scoreTitle = "Правильный ответ"
            score += 1
        }
        else {
            scoreTitle = "Неправильный ответ, это флаг \(countries[number].capitalized)"
            score -= 1
        }
    }
    }
    




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

