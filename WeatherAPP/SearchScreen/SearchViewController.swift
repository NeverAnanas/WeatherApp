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
        collectionView.contentInset = .init(top: .zero, left: 20, bottom: .zero, right: 20)
        
        return collectionView
    }()
    
    func changeTheme() {
        //
    }
    
    let addCityButton = BlueFilledButton(title: "Добавить город")
    let locationButton = LocationButton()
    var backImage = UIImage(named: "back_icon")?.withRenderingMode(.alwaysOriginal)
    
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
        return 5
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

