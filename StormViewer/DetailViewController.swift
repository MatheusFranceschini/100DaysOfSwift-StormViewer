//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Matheus Franceschini on 13/08/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedImage: String?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: selectedImage ?? ""))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        setupNavigationBar()

        // Do any additional setup after loading the view.
    }
    
    private func setupLayout() {
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 320),
            
        ])
    }
    
    func setupNavigationBar() {
        navigationItem.title = selectedImage
        navigationItem.largeTitleDisplayMode = .never
    }

}

#Preview {
    DetailViewController()
}
