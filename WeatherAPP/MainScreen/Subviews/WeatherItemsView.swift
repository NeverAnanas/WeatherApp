import UIKit

class WeatherItemsView: UIView {
    
    private var arrayForecast: [[Forecast]] = []
    private var days: [WeatherCellGray.WeatherCellGrayViewModel] = []
    private var converter = DateConverter()
    private var converterTemperature = TemperatureConverter()
    
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
            let convertedTemperature = converterTemperature.convertTemperatureToString(temperature: forecastDay.temperature)
            let convertedFeelsTemperature = converterTemperature.convertTemperatureAndAddWeatherState(feelsLike: forecastDay.feelsLike, weatherState: forecastDay)
            
            let model = WheatherCellBlue.WheatherCellBlueViewModel(
                currentDay: convertedDate,
                currentTemperature: convertedTemperature,
                currentFeelTemperature: convertedFeelsTemperature
            )
            
            cell.configure(model: model)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCellGray.id, for: indexPath) as! WeatherCellGray
            let forecast = arrayForecast[indexPath.row]
            let getTimeFromDate = DateConverter()
            let dateCurrent = forecast[0].date
            let convertedDate = converter.convertDateToString(date: dateCurrent)
            let convertedDayOfTheWeek = converter.converterDayOfTheWeek(date: dateCurrent)
            let convertedTemperature = converterTemperature.convertTemperatureToString(temperature: forecast[0].temperature)
            let convertedFeelsTemperature = converterTemperature.convertTemperatureToString(temperature: forecast[0].feelsLike)
            
            let eachHourForecast: [WeatherItemCell.WeatherItem] = forecast.map { forecast in
                
                let convertedTemp = converterTemperature.convertTemperatureToString(temperature: forecast.temperature)
                let viewModel = WeatherItemCell.WeatherItem(time: getTimeFromDate.getTimeFromDate(date: forecast.date), temperature: convertedTemp, emoji: forecast.icon)
                
                return viewModel
            }
            
            let viewModel = WeatherCellGray.WeatherCellGrayViewModel(
                date: convertedDate,
                temperature: convertedTemperature,
                feelTemperature: convertedFeelsTemperature,
                dayOfWeek: convertedDayOfTheWeek,
                eachHourForecast: eachHourForecast
            )
            
            cell.setWeather(day: viewModel)
            
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
