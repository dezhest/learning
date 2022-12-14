//
//  AddView.swift
//  MyCash
//
//  Created by Денис Жестерев on 26.09.2022.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode // для закрытия шита
    @ObservedObject var expenses : Expenses
    @State private var name = ""
    @State private var type = "Финансовый"
    @State private var amount: Double = 0
    @State private var selectedDate = Date()
    @State private var typeName = ""
    @State private var showsAlert = false
    @State private var alertInput = ""
    @State var types = ["Эмоциональный", "Финансовый"]
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    
    var body: some View {
        
        VStack {
            NavigationView {
                Form {
                    TextField("Что случилось?", text: $name)
                    
                    VStack(alignment: .leading) {
                        Text("Сила скама")
                        Slider(value: $amount, in: 0...10)
                        Text("\(Int(amount))")
                        
                    }
                    
                    
                    DatePicker("Когда был скам?", selection: $selectedDate, displayedComponents: .date).datePickerStyle(.compact)
                    Picker("Тип", selection: $type) {
                        ForEach(self.types, id: \.self) {
                            Text($0)
                        }
  
                    }
                    Button(action: {
                        showAlert()
                    }) {Text("Добавить свой тип")}
                        .alert("Добавить тип", isPresented: $showsAlert, actions: {
                            TextField("Тип скама", text: $alertInput)
                            Button("Добавить", action: {
                                types.append(alertInput)
                                type = alertInput
                            })
                            Button("Отмена", role: .cancel, action: {})
                        }, message: {
                            Text("Пожалуйста введите ваш тип скама")
                        })
                    
                }
                .navigationBarTitle("Добавить скам")
                .navigationBarItems(trailing: Button("Сохранить"){
                    let item = ExpenseItem(name: self.name, type: self.type, amount: self.amount, selectedDate: self.selectedDate)
//                    self.expenses.items.insert(item, at: 0)
                    self.presentationMode.wrappedValue.dismiss()
                })
            }
            VStack {
                
                if selectedImage != nil {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 120, height: 120)
                } else {
                    Image(systemName: "snow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 120, height: 120)
                }
                
                Button("Camera") {
                    self.sourceType = .camera
                    self.isImagePickerDisplay.toggle()
                }
                
                Button("Photo") {
                    self.sourceType = .photoLibrary
                    self.isImagePickerDisplay.toggle()
                }.padding()
            }
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }

        }
    
}
func showAlert() {
    self.showsAlert.toggle()
}
}


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddView(expenses: Expenses())
                .previewInterfaceOrientation(.portrait)
            AddView(expenses: Expenses())
                .previewInterfaceOrientation(.portrait)
        }
    }
}
