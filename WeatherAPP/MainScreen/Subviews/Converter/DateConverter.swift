import Foundation

class DateConverter {
    
    func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd, MMM"
        
        return dateFormatter.string(from: date)
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
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let time = "\(hour):\(minute)"
        
        return time
    }
    
}
