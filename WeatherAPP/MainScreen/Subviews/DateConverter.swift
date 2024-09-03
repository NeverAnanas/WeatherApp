import Foundation

class DateConverter {
    
    func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd, MMM"
        
        return dateFormatter.string(from: date)
    }
}
