//
//  CartCell.swift
//  TSD7UISegmentedControl
//
//  Created by Дмитрий Геращенко on 25.02.2022.
//

import UIKit

final class CartCell: UITableViewCell {
    
    static var reuseId: String {
        String(describing: Self.self)
    }
    private let productImage = UIImageView()
    private let productLabel = UILabel()
    private let productSize = UILabel()
    private let productQuantity = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureProductImage()
        configureProductLabel()
        configureProductSize()
        configureProductQuantity()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(Image: String, productLabel: String, productSize: String, productQuantity: String) {
        self.productLabel.text = productLabel
        self.productImage.image = UIImage(named: Image)
        self.productSize.text = "Size: \(productSize)"
        self.productQuantity.text = "Quantity: \(productQuantity)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.productLabel.text = nil
        self.productImage.image = nil
        self.productSize.text = nil
        self.productQuantity.text = nil
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return CGSize(width: targetSize.width, height: 100)
    }
    
    private func configureProductImage() {
        contentView.addSubview(productImage)
        productImage.contentMode = .scaleAspectFit
    }
    
    private func configureProductLabel() {
        contentView.addSubview(productLabel)
        productLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    private func configureProductSize() {
        contentView.addSubview(productSize)
        productSize.textColor = .secondaryLabel
    }
    
    private func configureProductQuantity() {
        contentView.addSubview(productQuantity)
        productQuantity.textColor = .secondaryLabel
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        productImage.frame = CGRect(x: 8, y: 0, width: contentView.frame.height, height: contentView.frame.height)
        productLabel.frame = CGRect(x: productImage.frame.width + 8, y: 2, width: contentView.frame.width - productImage.frame.width - 8, height: 22)
        productSize.frame = CGRect(x: productImage.frame.width + 8, y: productLabel.frame.origin.y + productLabel.frame.height + 2, width: contentView.frame.width - productImage.frame.width - 8, height: 22)
        productQuantity.frame = CGRect(x: productImage.frame.width + 8, y: productSize.frame.origin.y + productSize.frame.height + 2, width: contentView.frame.width - productImage.frame.width - 8, height: 22)
    }
}
