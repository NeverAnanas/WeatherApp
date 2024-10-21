import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
 
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 363, height: 60)
        layout.scrollDirection = .vertical
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(SearchItemCell.self, forCellWithReuseIdentifier: SearchItemCell.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = .init(top: .zero, left: 20, bottom: 80, right: 20)

        
        return collectionView
    }()
    
    func changeTheme() {
        //
    }
    
    let addCityButton = BlueFilledButton(title: "Добавить город")
    let locationButton = LocationButton()
    var backImage = UIImage(named: "back_icon")?.withRenderingMode(.alwaysOriginal)
    let maskedView = UIView(frame: CGRect(x: 50, y: 50, width: 256, height: 256))
    let gradientMaskLayer = CAGradientLayer()
    
    lazy var sunButton = ImageNavigationBarButton(image: .sun) { [weak self] in
        self?.changeTheme()
    }
    
    func setNavigatinItems() {
        navigationItem.rightBarButtonItem = sunButton
        navigationItem.title = "Мои города"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backTapped))
        self.navigationItem.hidesBackButton = true

    }
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func locationTapped() {
        print()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.layer.addSublayer(gradientMaskLayer)
        gradientMaskLayer.frame = view.bounds
        gradientMaskLayer.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor.white.cgColor]
        gradientMaskLayer.locations = [0.7, 0.9]
        
        // Set the start and end points for the gradient layer
        gradientMaskLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientMaskLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        addCityButton.layer.zPosition = 10
        locationButton.layer.zPosition = 11
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        setNavigatinItems()
       
        
        // collection
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // buttom
        view.addSubview(addCityButton)
        addCityButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(locationButton)
        locationButton.contentMode = .scaleToFill
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addCityButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 88),
            addCityButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            locationButton.leadingAnchor.constraint(equalTo: addCityButton.trailingAnchor, constant: 8),
            locationButton.centerYAnchor.constraint(equalTo: addCityButton.centerYAnchor)
        ])
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchItemCell.id, for: indexPath) as? SearchItemCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(model: SearchItemCell.SearchItem(
            name: "Москва",
            temperature: 30,
            feelTemperature: 35,
            imageResolver: MockImageResolver())
        )
        
        return cell
    }
}

final class MockImageResolver: IImageResolver {
    func resolve(completion: @escaping (UIImage?) -> Void) {
        completion(UIImage(systemName: "star.fill"))
    }
}

