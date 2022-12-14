//
//  Home.swift
//  TaskManager
//
//  Created by kazunari_ueeda on 2022/01/10.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    var array: [Bool]
    var array2: [Bool]
}


class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()

    {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        @State var count = items.count
    }
}


struct Home: View {
    
    @State private var array = [false, false, false, false, false, false, false]
    @State private var array2 = [false, false, false, false, false, false, false]
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    
    
    private let calendar: Calendar
    private let monthDayFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    private let timeFormatter: DateFormatter
    
    @State private var selectedDate = Self.now
    private static var now = Date() // Cache now
    
    init(calendar: Calendar) {
        self.calendar = calendar
        self.monthDayFormatter = DateFormatter(dateFormat: "dd/MM", calendar: calendar)
        self.dayFormatter = DateFormatter(dateFormat: "d", calendar: calendar)
        self.weekDayFormatter = DateFormatter(dateFormat: "EEE", calendar: calendar)
        self.timeFormatter = DateFormatter(dateFormat: "H:mm", calendar: calendar)
    }
    
    @ObservedObject var expenses = Expenses() // просим наблюдать за классом, когда паблишед меняется - меняется вью
    @State private var showingAddExpense = false // для создания новой страницы
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView() {
                    HStack {
                        VStack(alignment: .center, spacing: 10) {
                            Text(Date().formatted(date: .abbreviated, time: .omitted))
                                .foregroundColor(.gray)
                            //                        Text("Today")
                            //                            .font(.title.bold())
                        }
                        Spacer()
                        Button(action: {
                            self.showingAddExpense = true
                        }) {
                            Image(systemName: "plus")
                        }
                        .offset(x: -10)
                        .sheet(isPresented: $showingAddExpense) {
                            AddView(expenses: self.expenses)
                        }
                    }
                    .padding(.leading)
                    
                    CalendarWeekListView(
                        calendar: calendar,
                        date: $selectedDate,
                        content: { date in
                            Button(action: {
                                selectedDate = date
                                
                                withAnimation {
                                    taskModel.currentDay = date
                                }
                            }) {
                                VStack(spacing: 10) {
                                    Text(dayFormatter.string(from: date))
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                    
                                    Text(weekDayFormatter.string(from: date))
                                        .font(.system(size: 14))
                                    
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8, height: 8)
                                        .opacity(calendar.isDate(date, inSameDayAs: selectedDate) ? 1 : 0)
                                    
                                }
                                .foregroundStyle(calendar.isDate(date, inSameDayAs: selectedDate) ? .primary : .secondary)
                                .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDate) ? .white : .black)
                                .frame(width: 45, height: 90)
                                .background(
                                    ZStack {
                                        if calendar.isDate(date, inSameDayAs: selectedDate) {
                                            Capsule()
                                                .fill(Color.blue)
                                        }
                                    }
                                )
                            }
                        },
                        title: { date in
                            HStack {
                                Text(monthDayFormatter.string(from: selectedDate))
                                    .font(.headline)
                                    .padding(5)
                                Spacer()
                            }
                            .padding([.bottom, .leading], 10)
                        }, weekSwitcher: { date in
                            Button {
                                withAnimation(.easeIn) {
                                    guard let newDate = calendar.date(
                                        byAdding: .weekOfMonth,
                                        value: -1,
                                        to: selectedDate
                                    ) else {
                                        return
                                    }
                                    
                                    selectedDate = newDate
                                }
                            } label: {
                                Label(
                                    title: { Text("Previous") },
                                    icon: { Image(systemName: "chevron.left") }
                                )
                                .labelStyle(IconOnlyLabelStyle())
                                .padding(.horizontal)
                            }
                            .offset(x: -10)
                            Button {
                                withAnimation(.easeIn) {
                                    guard let newDate = calendar.date(
                                        byAdding: .weekOfMonth,
                                        value: 1,
                                        to: selectedDate
                                    ) else {
                                        return
                                    }
                                    
                                    selectedDate = newDate
                                }
                            } label: {
                                Label(
                                    title: { Text("Next") },
                                    icon: { Image(systemName: "chevron.right") }
                                )
                                .labelStyle(IconOnlyLabelStyle())
                                //                                .padding(.horizontal)
                            }
                            .offset(x: -10)
                        }
                    )
                }
               
                List {
                    ForEach(0 ..< expenses.items.count, id: \.self) { i in
                        HStack{
                            VStack(alignment: .leading){
                                Text(expenses.items[i].name)
                                    .font(.headline)
                                    .offset(x: 10)
                                HStack {
                                    ForEach(0 ..< array.count, id: \.self) { button in
                                        Rectangle()
                                            .frame(width: 30, height: 55)
                                            .foregroundColor(expenses.items[i].array2[button] == true ? .red : .gray)
                                            .opacity(expenses.items[i].array2[button] == true ? 1 : 0.9)
                                            .foregroundColor(expenses.items[i].array[button] == true ? .green : .white)
                                            .border(expenses.items[i].array[button] == true ? .green : .white, width: expenses.items[i].array[button] == true ? 20 : 0)
                                            .cornerRadius(30)
                                            .shadow(color: expenses.items[i].array[button] == true ? .gray : .white, radius: 5, x: 2, y: -2)
                                            .opacity(0.9)
                                            .padding(7.4)
                                            .offset(x: 3)
                                            .onTapGesture(){
                                                changeColor1(button, i)

                                            }
                                            .onLongPressGesture(minimumDuration: 0.7) {
                                                changeColor1(button, i)
                                                changeColor2(button, i)
                                                           }
                                    }
                                }
                                
                            }
                            Spacer()
                        }
                    }
                    .onDelete(perform: delete)
                }
                .offset(y: 168)
            }
        }
    }
    private func delete(with indexSet: IndexSet) {
        indexSet.forEach { expenses.items.remove(at: $0) }
        }
    
//    func removeItems(as offsets: IndexSet) {
//        expenses.items.remove(atOffsets: offsets)
//    } // можно и так удалять
    
    func test() -> Int {
       return expenses.items.count
    }
    
    func changeColor1(_ button: Int, _ i: Int) {
        expenses.items[i].array[button] = !expenses.items[i].array[button]
        expenses.items[i].array2[button] = false
    }
    
    func changeColor2(_ button: Int, _ i: Int) {
        expenses.items[i].array[button] = false
        expenses.items[i].array2[button] = !expenses.items[i].array2[button]
    }
}


// MARK: - Component

public struct CalendarWeekListView<Day: View, Title: View, WeekSwiter: View>: View {
    // Injected dependencies
    private var calendar: Calendar
    @Binding private var date: Date
    private let content: (Date) -> Day
    private let title: (Date) -> Title
    private let weekSwitcher: (Date) -> WeekSwiter
    
    // Constants
    private let daysInWeek = 7
    
    public init(
        calendar: Calendar,
        date: Binding<Date>,
        @ViewBuilder content: @escaping (Date) -> Day,
        @ViewBuilder title: @escaping (Date) -> Title,
        @ViewBuilder weekSwitcher: @escaping (Date) -> WeekSwiter
        
    ) {
        self.calendar = calendar
        self._date = date
        self.content = content
        self.title = title
        self.weekSwitcher = weekSwitcher
    }
    
    public var body: some View {
        let month = date.startOfMonth(using: calendar)
        let days = makeDays()
        
        VStack {
            HStack {
                self.title(month)
                self.weekSwitcher(month)
            }
            HStack {
                ForEach(days, id: \.self) { date in
                    content(date)
                }
                
            }
            
            Divider()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

// MARK: - Conformances

extension CalendarWeekListView: Equatable {
    public static func == (lhs: CalendarWeekListView<Day, Title, WeekSwiter>, rhs: CalendarWeekListView<Day, Title, WeekSwiter>) -> Bool {
        lhs.calendar == rhs.calendar && lhs.date == rhs.date
    }
}

// MARK: - Helpers

private extension CalendarWeekListView {
    func makeDays() -> [Date] {
        guard let firstWeek = calendar.dateInterval(of: .weekOfMonth, for: date),
              let lastWeek = calendar.dateInterval(of: .weekOfMonth, for: firstWeek.end - 1)
        else {
            return []
        }
        
        let dateInterval = DateInterval(start: firstWeek.start, end: lastWeek.end)
        
        print(calendar.generateDays(for: dateInterval))
        
        return calendar.generateDays(for: dateInterval)
    }
}

private extension Calendar {
    func generateDates(
        for dateInterval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates = [dateInterval.start]
        
        enumerateDates(
            startingAfter: dateInterval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            guard let date = date else { return }
            
            guard date < dateInterval.end else {
                stop = true
                return
            }
            
            dates.append(date)
        }
        
        return dates
    }
    
    func generateDays(for dateInterval: DateInterval) -> [Date] {
        generateDates(
            for: dateInterval,
            matching: dateComponents([.hour, .minute, .second], from: dateInterval.start)
        )
    }
}

private extension Date {
    func startOfMonth(using calendar: Calendar) -> Date {
        calendar.date(
            from: calendar.dateComponents([.year, .month], from: self)
        ) ?? self
    }
    
    func startOfDayTime(using calendar: Calendar) -> Date {
        calendar.date(
            from: calendar.dateComponents([.hour, .minute], from: self)
        ) ?? self
    }
}

private extension DateFormatter {
    convenience init(dateFormat: String, calendar: Calendar) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
    }
}
// MARK: - Previews

#if DEBUG
struct CalendarWeekView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Home(calendar: Calendar(identifier: .gregorian))
        }
    }
}


#endif
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(calendar: Calendar.current) // test only -> wrong
    }
}
