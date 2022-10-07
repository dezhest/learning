//
//  ContentView.swift
//  signUpPage
//
//  Created by Денис Жестерев on 06.10.2022.
//

//
//  ContentView.swift
//  signUpPage
//
//  Created by Денис Жестерев on 06.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var index = 0 // отвечает за переход между вкладками
    
    var body: some View {
        GeometryReader { _ in // чтоб дочерние вью подстраивались под размер родительских вью
            VStack(alignment: .center) {
                Image("airgap")
                    .resizable()
                    .frame(width: 150  , height: 75)
                ZStack {
                    SignUp2(index: self.$index)
                        .zIndex(Double(self.index)) // чтобы менять порядок вью добавили в последнюю очередб
                    Login(index: self.$index)
                }
                HStack(spacing: 15) { //15 между обьектами по горизонтали  {
                    Rectangle()
                        .fill(.yellow)
                        .frame(height: 2)
                    
                    Text("OR")
                        .foregroundColor(.white)
                    
                    Rectangle()
                        .fill(.yellow)
                        .frame(height: 2)
                }
                .padding(.horizontal, 30)
                .padding(.top, 50)
                
                HStack {
                    Button(action: {
                        //
                    }) {
                        Image("apple")
                            .resizable()
                            .renderingMode(.original) // чтобы не воспринимал как кнопку и не окрашивал в синий цвет
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    
                    Button(action: {
                        //
                    }) {
                        Image("fb")
                            .resizable()
                            .renderingMode(.original) // чтобы не воспринимал как кнопку и не окрашивал в синий цвет
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    Button(action: {
                        //
                    }) {
                        Image("twitter")
                            .resizable()
                            .renderingMode(.original) // чтобы не воспринимал как кнопку и не окрашивал в синий цвет
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                }
                .padding(.top, 30)
            }
            .padding(.vertical, 200)
        }
        .background(.black).edgesIgnoringSafeArea(.all)
        .preferredColorScheme(.dark) // делаем белыми буквами текст
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CShape: Shape {  // создание собственной формы
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.width, y:100))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: 0))
        }
    }
}

struct CShape1: Shape {  // создание собственной формы
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y:100))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
        }
    }
}

struct Login: View {
    @State var email = ""
    @State var pass  = ""
    @Binding var index: Int
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    VStack(spacing: 10) {
                        Text("Login")
                            .foregroundColor(self.index == 0 ? .white : .black)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Capsule()
                            .fill(self.index == 0 ? .blue : .clear) // clear - пусто
                            .frame(width: 100, height: 5)
                    }
                    
                    Spacer()
                }.padding(.top, 30)
                
                VStack {
                    HStack(spacing: 15) {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.black)
                        TextField("Email Adress", text: self.$email)
                            
                            

                    }
                    Divider()
                        .background(.white.opacity(0.5))
                } .padding(.horizontal)
                    .padding(.top, 40)
                
        
                
                VStack {
                    HStack(spacing: 15) {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(.black)
                        SecureField("Password", text: self.$pass)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                            
                           
                    }
                    Divider()
                        .background(.white.opacity(0.5))
                } .padding(.horizontal)
                    .padding(.top, 30)
                
                HStack {
                    Spacer (minLength: 0)
                    Button(action: {
                        //
                    }) {
                        Text("Forget password?")
                            .foregroundColor(.black.opacity(0.9))
                    }
                } .padding(.horizontal)
                    .padding(.top, 30)
                
            } .padding()
                .padding(.bottom, 65)
                .background(.orange)
                .clipShape(CShape())
                .contentShape(CShape())
                .shadow(color: Color.black.opacity(0.3), radius: 5, x:0 , y: -5 )
                .onTapGesture {
                    self.index = 0
                }
                .cornerRadius(35)
              
            
            Button(action: {
                //
            }) {
                Text("LOGIN")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 50)
                    .background(.orange)
                    .clipShape(Capsule())
                    .shadow(color: .white.opacity(0.8), radius: 5, x: 0, y: -5)
            }
            .offset(y: 35)
            .opacity(self.index == 0 ? 1: 0)
        }
    }
}

struct SignUp2: View {
    
    @State var email = ""
    @State var pass  = ""
    @State var pepass = ""
    @Binding var index: Int
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    Spacer(minLength: 0)
                    
                    VStack(spacing: 10) {
                        Text("Sing Up")
                            .foregroundColor(self.index == 1 ? .white : .black)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Capsule()
                            .fill(self.index == 1 ? .blue : .clear)
                            .frame(width: 100, height: 5)
                    }
                }
                .padding(.top, 30)
                
                VStack {
                    HStack(spacing: 15) {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.black)
                        TextField("Email Adress", text: self.$email)
                    }
                    Divider().background(.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                VStack {
                    HStack(spacing: 15) {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(.black)
                        SecureField("password", text: self.$pass)
                    }
                    Divider()
                        .background(.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                VStack {
                    HStack(spacing: 15) {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(.black)
                        SecureField("password", text: self.$pepass)
                    }
                    Divider().background(.black.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 40)
            }
            .padding()
            .padding(.bottom, 65)
            .background(.orange)
            .clipShape(CShape1())
            .contentShape(CShape1())
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
            .onTapGesture {
                self.index = 1
            }
            .cornerRadius(35)
            
            Button(action: {
                //
            }) {
                Text("SIGN UP")
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 50)
                    .background(.orange)
                    .clipShape(Capsule())
                    .contentShape(Capsule())
                    .shadow(color: .white.opacity(0.8), radius: 5, x: 0, y: -5)
            }
            .offset(y: 25)
            .opacity(self.index == 1 ? 1 : 0)
        }
    }
}
