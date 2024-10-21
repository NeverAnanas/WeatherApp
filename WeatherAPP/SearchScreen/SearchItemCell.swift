import UIKit

class SearchItemCell: UICollectionViewCell {
    
    static let id = "SearchItemCell"
    
    struct SearchItem {
        let name: String
        let temperature: Double
        let feelTemperature: Double
        let imageResolver: IImageResolver
    }
    
    private let nameCityLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let feelTemperatureLable = UILabel()
    private let imageView = UIImageView()
    private let containerView = UIView()
    private var imageResolver: IImageResolver?
    private var converterTemperature = TemperatureConverter()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor(named: "gray_10%")
        
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(nameCityLabel)
        nameCityLabel.font = .systemFont(ofSize: 16, weight: .medium)
        nameCityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(feelTemperatureLable)
        feelTemperatureLable.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .vertical)
        
        let constraint = nameCityLabel.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor, constant: -20)
        constraint.priority = .required
        constraint.isActive = true
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nameCityLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 118),
            nameCityLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 28),
            nameCityLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            nameCityLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            nameCityLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 18),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -18),
            
            feelTemperatureLable.widthAnchor.constraint(greaterThanOrEqualToConstant: 27),
            feelTemperatureLable.heightAnchor.constraint(greaterThanOrEqualToConstant: 28),
            feelTemperatureLable.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -16),
            feelTemperatureLable.centerYAnchor.constraint(equalTo: nameCityLabel.centerYAnchor),
            
            temperatureLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 27),
            temperatureLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 28),
            temperatureLabel.trailingAnchor.constraint(equalTo: feelTemperatureLable.leadingAnchor, constant: -8),
            temperatureLabel.centerYAnchor.constraint(equalTo: nameCityLabel.centerYAnchor)
        ])
        
        layer.cornerRadius = 16
    }
    
    func configure(model: SearchItem) {
        let tempToString = converterTemperature.convertTemperatureToString(temperature: model.temperature)
        let feelTempToString = converterTemperature.convertTemperatureToString(temperature: model.feelTemperature)
        
        nameCityLabel.text = model.name
        temperatureLabel.attributedText = converterTemperature.fontDesignationTemperature(temperature: tempToString)
        feelTemperatureLable.attributedText = converterTemperature.fontDesignationFeelsTemperature(feelTemperature: feelTempToString)
        imageResolver = model.imageResolver
        imageResolver?.resolve(completion: { [weak self] image in
            self?.imageView.image = image
        })
    }
}
