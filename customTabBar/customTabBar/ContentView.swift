//
//  ContentView.swift
//  customTabBar
//
//  Created by Денис Жестерев on 04.10.2022.
//

import SwiftUI

struct ContentView: View {
    @State var selected = 0
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                HStack {
                    Button(action: {
                        self.selected = 0
                    }) {
                        Image(systemName: "house.fill")
                    } .foregroundColor(self.selected == 0 ? .black : .gray)
                        Spacer(minLength: 12) // minLength between buttons
                    
                    Button(action: {
                        self.selected = 1
                    }) {
                        Image(systemName: "magnifyingglass")
                    } .foregroundColor(self.selected == 1 ? .black : .gray)
                    Spacer().frame(width: 120)
                    
                    Button(action: {
                        self.selected = 2
                    }) {
                        Image(systemName: "person.fill")
                    } .foregroundColor(self.selected == 2 ? .black : .gray)
                    Spacer(minLength: 12)
                    
                    Button(action: {
                        self.selected = 3
                    }) {
                        Image(systemName: "line.3.horizontal.decrease")
                    } .foregroundColor(self.selected == 3 ? .black : .gray)
                }
                .padding()
                .background(CurvedShape()) // нарисованная структура
                
                Button(action: {
                    //
                }) {
                    Image(systemName: "heart")
                        .renderingMode(.original) // шоб не окрашивал в синий цвет
                        .padding(18)
                }
                .background(.yellow)
                    .clipShape(Circle())
                    .offset(y: -30)
            }
        }
        .background((Color.mint).edgesIgnoringSafeArea(.top)) // игонорировать челку на айфоне, можно .all с низом b
    }
}

struct CurvedShape : View { // рисуем вырез у тулбара
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0)) // стоим в начале координат
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0)) // горизонтальная линяя
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 55))  // ширина прямоугольника
            path.addArc(center: CGPoint(x: UIScreen.main.bounds.width / 2, y: 55), radius: 35, startAngle: .zero, endAngle:  .init(degrees: 180), clockwise: true) // clokwise по часовой
            path.addLine(to: CGPoint(x: 0, y: 55))
        }
                .fill(.white)
                .rotationEffect(.init(degrees: 180)) // перевочачиваем арку вверх
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
