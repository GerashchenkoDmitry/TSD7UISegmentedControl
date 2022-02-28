//
//  CheckoutViewController.swift
//  TSD7UISegmentedControl
//
//  Created by Дмитрий Геращенко on 19.02.2022.
//

import UIKit

final class CartViewController: UIViewController {
    
    private let tableView = UITableView()
    private let quantityButton = UIButton(type: .system)
    
    static var items = [Product]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Cart"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    static func configureCart(with product: Product) {
        items.append(product)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureTableView()
        configureQuantityButton()
    }
    
    private func configureTableView() {
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        
        view.addSubview(tableView)
    }
    
    private func configureQuantityButton() {
        quantityButton.setTitle("Quantity: \(configureAllItemsQuantity())", for: .normal)
        quantityButton.tintColor = .white
        quantityButton.backgroundColor = .systemBlue
        
        view.addSubview(quantityButton)
    }
    
    private func configureAllItemsQuantity() -> String {
        var allQuantity = 0
        for item in CartViewController.items {
            guard let quantity = Int(item.quantity ?? "") else { return "" }
            allQuantity += quantity
        }
        return "\(allQuantity)"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.width, height: CGFloat(CartViewController.items.count) * tableView.rowHeight)
        quantityButton.frame = CGRect(x: view.frame.width / 3 * 2 + 8, y: tableView.frame.origin.y + tableView.frame.height + 8, width: view.frame.width / 3 - 16, height: 50)
        quantityButton.layer.cornerRadius = 15
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CartViewController.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = CartViewController.items[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.reuseId, for: indexPath) as? CartCell else { return UITableViewCell() }
        cell.configureCell(Image: "NB\(item.color ?? "")", productLabel: item.name, productSize: item.size ?? "", productQuantity: item.quantity ?? "")
        cell.selectionStyle = .none
        return cell
    }
}
