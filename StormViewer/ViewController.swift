//
//  ViewController.swift
//  StormViewer
//
//  Created by Matheus Franceschini on 12/08/24.
//

import UIKit
import MessageUI

class ViewController: UIViewController {
    
    var pictures = [String]()
    
    private lazy var pictureTableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Picture")
        return tableView
    }()

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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommendTapped))
    }
    
    @objc func recommendTapped() {
        let viewController = UIActivityViewController(activityItems: ["Hey, download this app!"], applicationActivities: [])
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(viewController, animated: true)
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 16)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewController = DetailViewController()
        detailViewController.selectedImage = pictures[indexPath.row]
        detailViewController.title = "Picture \(indexPath.row + 1) of \(pictures.count)"
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
