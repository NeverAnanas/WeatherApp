import UIKit

class BlueFilledButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        var configuration = UIButton.Configuration.filled() // 1
        configuration.cornerStyle = .capsule // 2
        configuration.baseForegroundColor = UIColor.white
        configuration.buttonSize = .large
        configuration.title = title
        
        var backgroundConfiguration = UIBackgroundConfiguration.clear()
        backgroundConfiguration.backgroundColor = UIColor(named: "blue")
        configuration.background = backgroundConfiguration
        
        self.configuration = configuration
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
