import UIKit


class WeatherCellGray: UIView {
    
    let buttomContainer = UIImageView()
    let lastWeatherIconViewGrey = UIImageView()
    let lastTemperatureLabel = UILabel()
    let lastTemperatureLabelBlack = UILabel()
    let lastTimeTemperature = UILabel()
    let collectionLayout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceHorizontal = true
        collectionView.register(WeatherItemCell.self, forCellWithReuseIdentifier: "weatherCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var weatherItems: [WeatherItem] = []
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionLayout.itemSize = CGSize(width: 73, height: 114)
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.minimumInteritemSpacing = 20
        collectionLayout.minimumLineSpacing = 20
        
        buttomContainer.isUserInteractionEnabled = true
        buttomContainer.translatesAutoresizingMaskIntoConstraints = false
        
        buttomContainer.image = UIImage(named: "backgroundGrey")
        buttomContainer.contentMode = .scaleAspectFit
        
        // image grey
        
        buttomContainer.addSubview(lastWeatherIconViewGrey)
        lastWeatherIconViewGrey.translatesAutoresizingMaskIntoConstraints = false
        
        lastWeatherIconViewGrey.image = UIImage(named: "mini_sun_icon")
        
        NSLayoutConstraint.activate([
            lastWeatherIconViewGrey.topAnchor.constraint(equalTo: buttomContainer.topAnchor, constant: 18),
            lastWeatherIconViewGrey.rightAnchor.constraint(equalTo: buttomContainer.rightAnchor, constant: -20),
        ])
        
        // text temperature
        
        buttomContainer.addSubview(lastTemperatureLabel)
        lastTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        lastTemperatureLabel.text = "29°"
        lastTemperatureLabel.font = .systemFont(ofSize: 17, weight: .bold)
        lastTemperatureLabel.textColor = .gray
        
        NSLayoutConstraint.activate([
            lastTemperatureLabel.topAnchor.constraint(equalTo: buttomContainer.topAnchor, constant: 18),
            lastTemperatureLabel.rightAnchor.constraint(equalTo: lastWeatherIconViewGrey.leftAnchor, constant: -16),
            lastTemperatureLabel.centerYAnchor.constraint(equalTo: lastWeatherIconViewGrey.centerYAnchor)
        ])
        
        buttomContainer.addSubview(lastTemperatureLabelBlack)
        lastTemperatureLabelBlack.translatesAutoresizingMaskIntoConstraints = false
        
        lastTemperatureLabelBlack.text = "25°"
        lastTemperatureLabelBlack.font = .systemFont(ofSize: 17, weight: .bold)
        
        NSLayoutConstraint.activate([
            lastTemperatureLabelBlack.topAnchor.constraint(equalTo: buttomContainer.topAnchor, constant: 18),
            lastTemperatureLabelBlack.rightAnchor.constraint(equalTo: lastTemperatureLabel.leftAnchor, constant: -8),
            lastTemperatureLabelBlack.centerYAnchor.constraint(equalTo: lastWeatherIconViewGrey.centerYAnchor)
        ])
        
        buttomContainer.addSubview(lastTimeTemperature)
        lastTimeTemperature.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedString = NSMutableAttributedString(
            string: "13 августа, пт",
            attributes: [
                .font: UIFont.systemFont(
                    ofSize: 16,
                    weight: .medium
                )
            ])
        
        attributedString.addAttributes(
            [.foregroundColor: UIColor.gray],
            range: NSRange(location: 12, length: 2))
        
        lastTimeTemperature.attributedText = attributedString
        
        NSLayoutConstraint.activate([
            lastTimeTemperature.topAnchor.constraint(equalTo: buttomContainer.topAnchor),
            lastTimeTemperature.centerYAnchor.constraint(equalTo: lastWeatherIconViewGrey.centerYAnchor),
            lastTimeTemperature.leftAnchor.constraint(equalTo: buttomContainer.leftAnchor, constant: 20)
        ])
        
        buttomContainer.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: buttomContainer.bottomAnchor, constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: buttomContainer.leadingAnchor, constant: 20),
            collectionView.topAnchor.constraint(equalTo: lastTimeTemperature.bottomAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: buttomContainer.trailingAnchor, constant: -20)
        ])
    }
    
    func setWeather(_ items: [WeatherItem]) {
        weatherItems = items
        collectionView.reloadData()
    }
    
}

extension WeatherCellGray: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherItemCell else {
            return UICollectionViewCell()
        }
        
        let weatherItem = weatherItems[indexPath.row]
        
        cell.configure(with: weatherItem.time, temperature: weatherItem.temperature, emoji: weatherItem.emoji)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherItems.count
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension WeatherCellGray: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
    
}
