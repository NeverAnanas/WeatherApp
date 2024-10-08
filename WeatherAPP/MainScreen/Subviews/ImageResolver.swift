import UIKit

protocol IImageResolver {
    func resolve(completion: @escaping (UIImage?) -> Void)
}

class ImageResolver: IImageResolver {
    private let imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
    }
    
    func resolve(completion: @escaping (UIImage?) -> Void) {
        let iconURL = "https://openweathermap.org/img/wn/\(imageName)@2x.png"
        
        guard let url = URL(string: iconURL) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                if let data = data {
                    let icon = UIImage(data: data)
                    completion(icon)
                } else {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
        
}
    

