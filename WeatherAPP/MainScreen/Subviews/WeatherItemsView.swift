import UIKit

class WeatherItemsView: UIView {
    
    private var arrayForecast: [[Forecast]] = []
    private var days: [WeatherCellGray.WeatherCellGrayViewModel] = []
    private var converter = DateConverter()
    
    func saveArray(array: [[Forecast]]) {
        arrayForecast = array
        collectionView.reloadData()
    }
    
    func setWeather(days: [WeatherCellGray.WeatherCellGrayViewModel]) {
        self.days = days
        collectionView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Private
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(WeatherCellGray.self, forCellWithReuseIdentifier: WeatherCellGray.id)
        collectionView.register(WheatherCellBlue.self, forCellWithReuseIdentifier: WheatherCellBlue.id)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private func setupViews() {
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 16)
        ])
    }
}

extension WeatherItemsView: UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension WeatherItemsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayForecast.count
    }
    
    // ячейка
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WheatherCellBlue.id, for: indexPath) as! WheatherCellBlue
            let forecast = arrayForecast[0]
            let forecastDay = forecast[0]
            let forecastDate = forecastDay.date
            let convertedDate = converter.convertDateToString(date: forecastDate)
            
            
            let model = WheatherCellBlue.WheatherCellBlueViewModel(
                currentDay: convertedDate,
                currentTemperature: String(forecastDay.temperature),
                currentFeelTemperature: String(forecastDay.feelsLike)
            )
            
            cell.configure(model: model)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCellGray.id, for: indexPath) as! WeatherCellGray
            
            let day = days[indexPath.row]
            
            cell.setWeather(day: day)
            
            return cell
        }
    }
}

extension WeatherItemsView: UICollectionViewDelegateFlowLayout {
    
    // размер
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width, height: 280)
        }
        return CGSize(width: collectionView.frame.width, height: 206)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 8
        }
}
