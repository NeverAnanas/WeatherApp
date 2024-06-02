//
//  SecondViewController.swift
//  WeatherAPP
//
//  Created by Анастасия Неверова on 02.06.2024.
//

import UIKit

protocol SecondViewControllerDelegate {
    func sumToNumbers(number1: Int, number2: Int) -> Int
}

class SecondViewController: UIViewController {
    
    var delegate: SecondViewControllerDelegate?
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("tap me to change color", for: .normal)
        
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func changeColor() {
        let result = delegate?.sumToNumbers(number1: 1, number2: 2)
        print(result)
    }
}
