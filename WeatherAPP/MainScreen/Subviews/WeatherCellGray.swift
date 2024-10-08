import UIKit

class WeatherCellGray: UICollectionViewCell {
    
    static let id = "WeatherCellGray"
    
    struct WeatherCellGrayViewModel {
        let date: String
        let temperature: String
        let feelTemperature: String
        let imageResolver: IImageResolver
        let eachHourForecast: [WeatherItemCell.WeatherItem]
    }
    
    private var imageResolver: IImageResolver?
    
    let buttomContainer = UIView()
    let lastWeatherIconViewGrey = UIImageView()
    let currentFeelTemperatureLabel = UILabel()
    let currentTemperatureLabelBlack = UILabel()
    let dateLabel = UILabel()
    let collectionLayout = UICollectionViewFlowLayout()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceHorizontal = true
        collectionView.register(WeatherItemCell.self, forCellWithReuseIdentifier: "weatherCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = .init(top: .zero, left: 20, bottom: .zero, right: 20)
        
        return collectionView
    }()
    
    var lineView = LineView()
    
    func setWeather(day: WeatherCellGrayViewModel) {
        weatherItems = day.eachHourForecast

        setDate(date: day.date)
        setTemperature(temperature: day.temperature, feelTemperature: day.feelTemperature)
        
        imageResolver = day.imageResolver
        imageResolver?.resolve(completion: { [weak self] image in
            self?.lastWeatherIconViewGrey.image = image
        })
        
        collectionView.reloadData()
    }
    
    class LineView: UIView {
        override func draw(_ rect: CGRect) {
            guard let context = UIGraphicsGetCurrentContext() else {
                return
            }
            
            context.setStrokeColor(UIColor(named: "light_gray")?.cgColor ?? UIColor.gray.cgColor)
            
            context.setLineWidth(2.0)
            
            let startPoint = CGPoint(x: rect.minX, y: rect.midY)
            let endPoint = CGPoint(x: rect.maxX, y: rect.midY)
            
            context.move(to: startPoint)
            
            context.addLine(to: endPoint)
            
            context.strokePath()
        }
    }
    
    private var weatherItems: [WeatherItemCell.WeatherItem] = []
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor(named: "very_light_gray")
        
        collectionLayout.itemSize = CGSize(width: 73, height: 114)
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.minimumInteritemSpacing = 8
        collectionLayout.minimumLineSpacing = 8
//        collectionLayout.
        
        addSubview(buttomContainer)
        buttomContainer.isUserInteractionEnabled = true
        buttomContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttomContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttomContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttomContainer.topAnchor.constraint(equalTo: topAnchor),
            buttomContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        layer.cornerRadius = 16
        
        buttomContainer.addSubview(lineView)
        lineView.frame = CGRect(x: .zero, y: .zero, width: 303, height: .zero)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: buttomContainer.topAnchor, constant: 60),
            lineView.leftAnchor.constraint(equalTo: buttomContainer.leftAnchor, constant: 20),
            lineView.rightAnchor.constraint(equalTo: buttomContainer.rightAnchor, constant: -20),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])

        // image grey
        
        buttomContainer.addSubview(lastWeatherIconViewGrey)
        lastWeatherIconViewGrey.translatesAutoresizingMaskIntoConstraints = false
        lastWeatherIconViewGrey.contentMode = .scaleToFill
        
        NSLayoutConstraint.activate([
            lastWeatherIconViewGrey.topAnchor.constraint(equalTo: buttomContainer.topAnchor, constant: 18),
            lastWeatherIconViewGrey.rightAnchor.constraint(equalTo: lineView.rightAnchor),
            lastWeatherIconViewGrey.widthAnchor.constraint(equalToConstant: 30),
            lastWeatherIconViewGrey.heightAnchor.constraint(equalToConstant: 27)
            
            
        ])
        
        // text temperature
        
        buttomContainer.addSubview(currentFeelTemperatureLabel)
        currentFeelTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentFeelTemperatureLabel.topAnchor.constraint(equalTo: buttomContainer.topAnchor, constant: 18),
            currentFeelTemperatureLabel.rightAnchor.constraint(equalTo: lastWeatherIconViewGrey.leftAnchor, constant: -16),
            currentFeelTemperatureLabel.centerYAnchor.constraint(equalTo: lastWeatherIconViewGrey.centerYAnchor)
        ])
        
        buttomContainer.addSubview(currentTemperatureLabelBlack)
        currentTemperatureLabelBlack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentTemperatureLabelBlack.topAnchor.constraint(equalTo: buttomContainer.topAnchor, constant: 18),
            currentTemperatureLabelBlack.rightAnchor.constraint(equalTo: currentFeelTemperatureLabel.leftAnchor, constant: -8),
            currentTemperatureLabelBlack.centerYAnchor.constraint(equalTo: lastWeatherIconViewGrey.centerYAnchor)
        ])
        
        buttomContainer.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: buttomContainer.topAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: lastWeatherIconViewGrey.centerYAnchor),
            dateLabel.leftAnchor.constraint(equalTo: lineView.leftAnchor)
        ])
        
        buttomContainer.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: buttomContainer.bottomAnchor, constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: buttomContainer.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: buttomContainer.trailingAnchor)
        ])
    }
    
    private func setTemperature(temperature: String, feelTemperature: String) {
        let nowTemperature = NSMutableAttributedString(
            string: temperature,
            attributes: [
                .font: UIFont.systemFont(
                    ofSize: 17,
                    weight: .bold
                )]
            )
        currentTemperatureLabelBlack.attributedText = nowTemperature
        
        let feelingTemperature = NSMutableAttributedString(
            string: feelTemperature,
            attributes: [
                .font: UIFont.systemFont(
                    ofSize: 17,
                    weight: .bold),
                    .foregroundColor: UIColor.gray
                ]
        )
        currentFeelTemperatureLabel.attributedText = feelingTemperature
        
    }
    
    private func setDate(date: String) {
        let text = NSMutableAttributedString(
            string: date,
            attributes: [
                .font: UIFont.systemFont(
                    ofSize: 16,
                    weight: .medium
                )
            ])
        
        guard text.length >= 2 else {
            dateLabel.attributedText = text
            return
        }
        
        let range = NSRange(location: text.length - 2, length: 2)
        text.addAttribute(.foregroundColor, value: UIColor.gray, range: range)
        
        dateLabel.attributedText = text
    }
    
}

extension WeatherCellGray: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherItemCell else {
            return UICollectionViewCell()
        }
        
        let weatherItem = weatherItems[indexPath.row]
        
        cell.configure(model: WeatherItemCell.WeatherItem(time: weatherItem.time, temperature: weatherItem.temperature, imageResolver: weatherItem.imageResolver)
        )
        
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
