import Foundation

class DateConverter {
    
    func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        let dayOfTheWeek = converterDayOfTheWeek(date: date)
        
        dateFormatter.dateFormat = "d MMMM"
        
        var string = dateFormatter.string(from: date) + ", " + dayOfTheWeek
        
        if Calendar.current.isDateInToday(date) {
            string = "Сегодня, " + string
        }
        
        return string
    }
    
    func converterDayOfTheWeek(date: Date) -> String {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        
        switch weekday {
        case 1: return "вс"
        case 2: return "пн"
        case 3: return "вт"
        case 4: return "ср"
        case 5: return "чт"
        case 6: return "пт"
        case 7: return "сб"
        default:
            return ""
        }
    }
    
    func getTimeFromDate(date: Date) -> String {
        let calendar = Calendar.current
        var hour = String(calendar.component(.hour, from: date))
        var minute = String(calendar.component(.minute, from: date))
        
        if hour.count == 1 {
            hour = "0\(hour)"
        }
        if minute.count == 1{
            minute = "0\(minute)"
        }
        
        let time = "\(hour):\(minute)"
        
        return time
    }
}
