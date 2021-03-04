
import SwiftUI

// MARK: - Picker Style
enum DatePickerViewStyle {
    case wheelPicker
    case datePicker
    case completeDatePicker
}

// MARK: - Calendar View
struct CalendarView: View {
    // MARK: - Properties
    @Binding var date: Date
    @Binding var isActive: Bool
    @Binding var chooseDate: Bool
    var range: PartialRangeFrom<Date>?
    var closeRange: PartialRangeThrough<Date>?
    let colorMultiply: Color
    private let style: DatePickerViewStyle
    // MARK: - Initializer
    init(date: Binding<Date>, chooseDate: Binding<Bool>, isActive: Binding<Bool>, style: DatePickerViewStyle, range: PartialRangeFrom<Date>? = nil, closeRange: PartialRangeThrough<Date>? = nil, colorMultiply: Color) {
        _chooseDate = chooseDate
        _date = date
        _isActive = isActive
        self.range = range
        self.closeRange = closeRange
        self.style = style
        self.colorMultiply = colorMultiply
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            switch style {
            case .completeDatePicker :
                if let range = range {
                    DatePicker("Choose date", selection: $date, in: range)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .colorMultiply(colorMultiply)
                } else {
                    DatePicker("Choose date", selection: $date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .colorMultiply(colorMultiply)
                }
                
            case .wheelPicker:
                DatePicker("", selection: $date, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                    .colorMultiply(colorMultiply)
            case .datePicker:
                if let closeRange = closeRange {
                    DatePicker("Start Date", selection: $date, in: closeRange, displayedComponents: [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .colorMultiply(colorMultiply)
                } else if let range = range {
                    DatePicker("Start Date", selection: $date, in: range, displayedComponents: [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .colorMultiply(colorMultiply)
                } else {
                    DatePicker("Start Date", selection: $date, displayedComponents: [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .colorMultiply(colorMultiply)
                }
            }
        }
        .padding(.horizontal)
    }
    
}

// MARK: - Preview
struct CalendarView_Previews: PreviewProvider {
    @State static var date = Date()
    static var previews: some View {
        Group {
            CalendarView(date: $date, chooseDate: .constant(true), isActive: .constant(true), style: .wheelPicker, colorMultiply: Color.blue)
                .previewLayout(.sizeThatFits)
            
            CalendarView(date: $date, chooseDate: .constant(true), isActive: .constant(true), style: .datePicker, colorMultiply: Color.green)
                .previewLayout(.sizeThatFits)
            
            CalendarView(date: $date, chooseDate: .constant(true), isActive: .constant(true), style: .completeDatePicker, colorMultiply: Color.white)
                .previewLayout(.sizeThatFits)
        }
    }
}
