import UIKit

class WheatherCellBlue: UICollectionViewCell {
    static let id = "WeatherCellBlue"
    
    private let topContainer = UIImageView()
    private let currentDayLabel = UILabel()
    private let currentWeatherIconView = UIImageView()
    private let currentTemperatureLabel = UILabel()
    private let currentFeelTemperatureLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupSubviews()
        layoutCurrentWeatherView()
    }
    
    struct WheatherCellBlueViewModel {
        let currentDay: String
        let currentTemperature: String
        let currentFeelTemperature: String
        let imageResolver: ImageResolver
    }
    
    func configure(model: WheatherCellBlueViewModel) {
        currentDayLabel.text = model.currentDay
        currentTemperatureLabel.text = model.currentTemperature
        currentFeelTemperatureLabel.text = model.currentFeelTemperature
        model.imageResolver.resolve { image in
            self.currentWeatherIconView.image = image?.resizeImage(targetSize: CGSize.init(width: 150, height: 150))
        }
        
    }
    
    // MARK: - Private
    
    private func setupSubviews() {
        topContainer.image = UIImage(named: "Group 33510")
        topContainer.clipsToBounds = true
        
        currentDayLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        currentDayLabel.textColor = .white
        currentDayLabel.textAlignment = .center
        
        currentTemperatureLabel.font = .systemFont(ofSize: 48, weight: .bold)
        currentTemperatureLabel.textColor = .white
        
        currentFeelTemperatureLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        currentFeelTemperatureLabel.textColor = .white
    }
    
    private func layoutCurrentWeatherView() {
        
        addSubview(topContainer)
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            topContainer.topAnchor.constraint(equalTo: topAnchor),
            topContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            topContainer.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // text
        
        topContainer.addSubview(currentDayLabel)
        currentDayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentDayLabel.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 16),
            currentDayLabel.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            currentDayLabel.leadingAnchor.constraint(greaterThanOrEqualTo: topContainer.leadingAnchor, constant: 50),
            currentDayLabel.trailingAnchor.constraint(greaterThanOrEqualTo: topContainer.trailingAnchor, constant: -50),
        ])
        
        // image
        
        topContainer.addSubview(currentWeatherIconView)
        currentWeatherIconView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentWeatherIconView.topAnchor.constraint(equalTo: currentDayLabel.bottomAnchor),
            currentWeatherIconView.centerXAnchor.constraint(equalTo: currentDayLabel.centerXAnchor)
        ])
        
        // temperature label
        
        topContainer.addSubview(currentTemperatureLabel)
        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentTemperatureLabel.topAnchor.constraint(equalTo: currentWeatherIconView.bottomAnchor, constant: -10),
            currentTemperatureLabel.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor)
        ])
        
        // feel temperature label
        
        topContainer.addSubview(currentFeelTemperatureLabel)
        currentFeelTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentFeelTemperatureLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor),
            currentFeelTemperatureLabel.centerXAnchor.constraint(equalTo: currentTemperatureLabel.centerXAnchor)
        ])
    }
}
