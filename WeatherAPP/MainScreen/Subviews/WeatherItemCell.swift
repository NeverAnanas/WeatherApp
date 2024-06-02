import UIKit

class WeatherItemCell: UICollectionViewCell {
    
    struct Configuration {
        let time: String
        let temperature: String
    }
    
    private let timeLabel = UILabel()
    let containerBackground = UIView()
    let temperature = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .gray
        
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.text = "12:00"
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        layer.cornerRadius = 16
    }
    
    func configure(_ configuration: Configuration) {
        timeLabel.text = configuration.time
    }
    
    
}

#Preview {
    WeatherItemCell()
}
