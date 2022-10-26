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
    @State private var type = "Color"
    let types = ["Красный", "Зеленый"]
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Название", text: $name)
                Picker("Цвет", selection: $type) {
                    ForEach(self.types, id: \.self) {
                        Text($0)
                    }
                }
           
        }
        .navigationBarTitle("Добавить")
        .navigationBarItems(trailing: Button("Сохранить"){
          
                let item = ExpenseItem(name: self.name)
                self.expenses.items.append(item)
                self.presentationMode.wrappedValue.dismiss()
           
                
        })
    }
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
