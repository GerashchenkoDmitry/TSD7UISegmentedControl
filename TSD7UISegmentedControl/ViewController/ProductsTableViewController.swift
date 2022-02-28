//
//  ProductsViewController.swift
//  TSD7UISegmentedControl
//
//  Created by Дмитрий Геращенко on 19.02.2022.
//

import UIKit

final class ProductsTableViewController: UIViewController {
    
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    private let productsArray = [Product(name: "New Balance", color: "Gray", size: "7", quantity: "1"), Product(name: "Cloth", color: "Red", size: "50", quantity: "1")]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Products"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseId)
    }
}

extension ProductsTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.productsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseId, for: indexPath) as? ProductCell else { return UITableViewCell() }
        cell.configureCell(productLabel: productsArray[indexPath.row].name,
                           Image: "NB\(productsArray[indexPath.row].color ?? "")")
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productViewController = ProductViewController(product: productsArray[indexPath.row])
        navigationController?.pushViewController(productViewController, animated: true)
    }
}
