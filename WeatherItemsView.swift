import UIKit

class WeatherItemsView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .systemGreen
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(WeatherCellGray.self, forCellWithReuseIdentifier: WeatherCellGray.id)
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCellGray.id, for: indexPath) as! WeatherCellGray
        
        let day = days[indexPath.row]
        
        cell.setWeather(day: day)
        
        return cell
    }
}

extension WeatherItemsView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 206)
    }
}
