import UIKit

class WeatherItemCell: UICollectionViewCell {
    
    struct WeatherItem {
        let time: String
        let temperature: String
        let imageResolver: ImageResolver
    }
    
    private let timeLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let emojiImageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor(named: "light_gray")
        
        addSubview(timeLabel)
        timeLabel.font = .systemFont(ofSize: 16, weight: .medium)
        timeLabel.textColor = .gray
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(temperatureLabel)
        temperatureLabel.font = .systemFont(ofSize: 16, weight: .bold)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(emojiImageView)
        emojiImageView.translatesAutoresizingMaskIntoConstraints = false
        emojiImageView.contentMode = .scaleAspectFill
        
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emojiImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
            emojiImageView.centerXAnchor.constraint(equalTo: timeLabel.centerXAnchor),
            emojiImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            emojiImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            temperatureLabel.topAnchor.constraint(equalTo: emojiImageView.bottomAnchor, constant: 10),
            temperatureLabel.centerXAnchor.constraint(equalTo: emojiImageView.centerXAnchor)
        ])
        
        layer.cornerRadius = 16
    }
    
    func configure(model: WeatherItem) {
        timeLabel.text = model.time
        temperatureLabel.text = model.temperature
        model.imageResolver.resolve { image in
            self.emojiImageView.image = image
        }
        
    }
}

#Preview {
    WeatherItemCell()
}
