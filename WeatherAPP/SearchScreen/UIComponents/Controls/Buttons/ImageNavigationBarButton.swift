import UIKit

class ImageNavigationBarButton: UIBarButtonItem {
    
    private let actionClousure: () -> Void
    enum Image: String, RawRepresentable {
        case sun = "sun_icon"
        case search = "search_icon"
        case map = "map_icon"
    }
    
    @objc func buttonTappedAction() {
        actionClousure()
    }
    
    init(image: Image, action: @escaping () -> Void) {
        self.actionClousure = action
        
        super.init()
        
        var image = UIImage(named: image.rawValue)?.withRenderingMode(.alwaysOriginal)
        
        self.image = image
        self.style = .plain
        self.target = self
        self.action = #selector(buttonTappedAction)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
