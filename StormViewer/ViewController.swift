//
//  ViewController.swift
//  StormViewer
//
//  Created by Matheus Franceschini on 12/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var pictureTableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Picture")
        return tableView
    }()
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupFileManager()
        setupLayout()
        setupNavigationBar()
    }

    private func setupFileManager() {
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: path).sorted()
        
        for item in items {
            if item.hasPrefix("img") {
                pictures.append(item)
            }
        }
        
        print(pictures)
    }
    
    func setupLayout() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(pictureTableView)
        
        NSLayoutConstraint.activate([
            pictureTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pictureTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pictureTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pictureTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Storm Viewer"
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.selectedImage = pictures[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
