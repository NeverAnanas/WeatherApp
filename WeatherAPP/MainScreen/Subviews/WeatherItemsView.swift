import UIKit

class WeatherItemsView: UIView {
    
    lazy var collectionView: UICollectionView = {
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
    
    private var days: [WeatherCellGray.WeatherDay] = []
    
    func setWeather(days: [WeatherCellGray.WeatherDay]) {
        self.days = days
        collectionView.reloadData()
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            setupViews()
            setupConstraints()
    }
    
    func setupViews() {
            addSubview(collectionView)
    }
    
    func setupConstraints() {
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
        return days.count
    }
    
    // ячейка
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WheatherCellBlue.id, for: indexPath) as! WheatherCellBlue
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
