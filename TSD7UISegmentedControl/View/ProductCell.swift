//
//  ProductTableViewCell.swift
//  TSD7UISegmentedControl
//
//  Created by Дмитрий Геращенко on 19.02.2022.
//

import UIKit

final class ProductCell: UITableViewCell {
    
    static var reuseId: String {
        String(describing: Self.self)
    }
    
    private let productLabel = UILabel()
    private let productImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureProductImage()
        configureProductLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(productLabel: String, Image: String) {
        self.productLabel.text = productLabel
        self.productImage.image = UIImage(named: Image)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productLabel.text = nil
        self.productImage.image = nil
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        productImage.frame = CGRect(x: 8, y: 0, width: contentView.frame.height, height: contentView.frame.height)
        productLabel.frame = CGRect(x: productImage.frame.width + 8, y: 0, width: contentView.frame.width - productImage.frame.width - 8, height: contentView.frame.height)
    }
}
