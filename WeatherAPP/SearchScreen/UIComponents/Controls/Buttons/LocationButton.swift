import UIKit

final class LocationButton: UIButton {
    
    lazy var locationImageView: UIView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true 

        let image = UIImage(named: "map_big_icon")?.withRenderingMode(.alwaysOriginal)
        imageView.image = image
        
        return imageView
    }()
    
    override func layoutSubviews() {
        addSubview(locationImageView)
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationImageView.leftAnchor.constraint(equalTo: leftAnchor),
            locationImageView.rightAnchor.constraint(equalTo: rightAnchor),
            locationImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            locationImageView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
