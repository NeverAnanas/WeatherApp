import UIKit

class SearchCellGray: UICollectionViewCell {

    static let id = "SearchCellGray"
    
    struct SearchCellGrayViewModel {
        let name: String
        let temperature: String
        let feelTemperature: String
        let imageResolver: IImageResolver
    }
    
    private var imageResolver: IImageResolver?
    private var converterTemperature = TemperatureConverter()
    
    let cityNameLabel = UILabel()
    var temperatureLable = UILabel()
    var feelTemperatureLabel = UILabel()
    let iconView = UIImageView()
    
    func setCity(city: SearchCellGrayViewModel) {
        cityNameLabel.text = city.name
        temperatureLable.attributedText = converterTemperature.fontDesignationTemperature(temperature: city.temperature)
        feelTemperatureLabel.attributedText = converterTemperature.fontDesignationFeelsTemperature(feelTemperature: city.feelTemperature)
        imageResolver = city.imageResolver
        
    }
}
