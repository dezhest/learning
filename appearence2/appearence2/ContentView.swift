//
//  ContentView.swift
//  appearence2
//
//  Created by Денис Жестерев on 30.09.2022.
//

import SwiftUI



struct ContentView: View {
    @State private var rotation = 0.0
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("wut")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .colorMultiply(.green) // оттенок
                .saturation(10) // насыщенность
                .contrast(1) //контраст
            Text("This foto was made by:")
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 5))
            Circle()
                .stroke(Color.red, style: StrokeStyle(lineWidth: 10, dash: [10, 30])) //в дэш первое число длина линии и второе расстояние между ними
                .frame(width: 150, height: 150)
                .offset(y: -450)
            Button(action: {print("Button tapped")})
            {
                Image(systemName: "cloud.fill")
                    .foregroundColor(.white)
                    .padding()
                    .background(.orange)
                    .clipShape(Capsule())  //овал
            }
            .offset(y: -505)
            
            
            VStack {
                Text("first")
                    .rotationEffect(.degrees(90))
                Text("second")
                    .offset(x: -60, y: 15) //ноль слева сверху, вниз положительные
                Text("third")
                    .padding(10)
                    .border(.red, width: 1)
                    .shadow(color: .red, radius: 3, x: 15, y: 10)
                Slider(value: $rotation, in: 0...360, step: 1)
                Text("Rotation")
                    .font(.largeTitle)
                    .background(.green)
                    .cornerRadius(20)
                    .blur(radius: 2)  // размытие
                    .opacity(0.5)  // видимость
                    .rotationEffect(.degrees(rotation), anchor: .topLeading)
                
            }
            .offset(y: 220)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
