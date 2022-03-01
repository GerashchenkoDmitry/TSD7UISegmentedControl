//
//  ViewController.swift
//  TSD7UISegmentedControl
//
//  Created by Дмитрий Геращенко on 15.02.2022.
//

import UIKit

final class ProductViewController: UIViewController {
    
    private var product: Product
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let productImage = UIImageView()
    private let productLabel = UILabel()
    private let colorLabel = UILabel()
    private var colorSegmentedControl = UISegmentedControl()
    private let sizeLabel = UILabel()
    private let sizeTextField = SizeTextField()
    private let quantityLabel = UILabel()
    private let quantityTextField = UITextField()
    private let toCartButton = UIButton(type: .system)
    
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
        configureUI()
        hideKeyboard()
    }
    
    // MARK: Configure All user interface
    // Call user interface functions
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        configureShareButton()
        configureProductImage()
        configureProductLabel()
        configureColorlabel()
        configureColorSegmentedControl()
        configureSizeLabel()
        configureSizeTextField()
        configureQuantityLabel()
        configureQuantityTextField()
        configureToCartButton()
    }
    
    // MARK: Configure shareBarButton
    
    private func configureShareButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
    }
    
    // MARK: Configure productImageView
    
    private func configureProductImage() {
        let viewWidth = view.bounds.width
        productImage.image = UIImage(named: "NB\(product.color ?? "")")
        productImage.frame = CGRect(x: 0,
                                    y: (navigationController?.navigationBar.frame.height)! + 16,
                                    width: viewWidth,
                                    height: viewWidth)
        productImage.contentMode = .scaleAspectFit
        
        view.addSubview(productImage)
    }
    
    // MARK: Configure productLabel
    
    private func configureProductLabel() {
        let viewWidth = view.bounds.width
        productLabel.text = product.name
        productLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        productLabel.frame = CGRect(x: 8,
                                    y: productImage.frame.origin.y + productImage.frame.height + 16,
                                    width: viewWidth - 16,
                                    height: 22)
        view.addSubview(productLabel)
    }
    
    // MARK: Configure productColorLabel
    
    private func configureColorlabel() {
        let viewWidth = view.bounds.width
        
        colorLabel.frame = CGRect(x: 8,
                                  y: productLabel.frame.origin.y + productLabel.frame.height + 16,
                                  width: viewWidth / 8 * 3,
                                  height: 22)
        colorLabel.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        colorLabel.text = "Select Color"
        
        view.addSubview(colorLabel)
    }
    
    // MARK: Configure segmentedControlLabel
    // SegmentedControl .valueChanged select color of the product
    
    private func configureColorSegmentedControl() {
        let colorArray = ["White", "Gray", "Red"]
        let viewWidth = view.bounds.width
        guard let color = product.color else { return }
        
        colorSegmentedControl = UISegmentedControl(items: colorArray)
        colorSegmentedControl.selectedSegmentIndex = colorArray.firstIndex(of: color) ?? 0
        colorSegmentedControl.frame = CGRect(x: colorLabel.frame.origin.x + colorLabel.frame.width,
                                             y: colorLabel.frame.origin.y - 4,
                                             width: viewWidth - colorLabel.frame.width - 16,
                                             height: 30)
        colorSegmentedControl.addTarget(self, action: #selector(selectColor), for: .valueChanged)
        
        view.addSubview(colorSegmentedControl)
    }
    
    // MARK: Configure productSizeLabel
    
    private func configureSizeLabel() {
        let viewWidth = view.bounds.width
        
        sizeLabel.frame = CGRect(x: 8,
                                 y: colorLabel.frame.origin.y + colorLabel.frame.height + 8,
                                 width: viewWidth / 3,
                                 height: 22)
        sizeLabel.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        sizeLabel.text = "Select Size"
        
        view.addSubview(sizeLabel)
    }
    
    // MARK: Configure productSizeTextField
    // Invoke UIPickerView on tap and set it's value to sizeTextField on picker .valueChanged
    
    private func configureSizeTextField() {
        let picker = UIPickerView()
        
        picker.dataSource = self.sizeTextField
        picker.delegate = self.sizeTextField
        picker.backgroundColor = .systemBackground
        
        let viewWidth = view.bounds.width
        sizeTextField.frame = CGRect(x: viewWidth / 8 * 7 - sizeLabel.frame.origin.x,
                                     y: sizeLabel.frame.origin.y,
                                     width: viewWidth / 8,
                                     height: 22)
        sizeTextField.borderStyle = .roundedRect
        sizeTextField.textAlignment = .center
        sizeTextField.inputView = picker
        sizeTextField.placeholder = "7"
        
        // Configure view similar as UIToolBar
        
        let wrappedView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: viewWidth,
                                               height: 44))
        wrappedView.backgroundColor = .systemGray5
        sizeTextField.inputAccessoryView = wrappedView
        
        // Configure Done Button when calling picker
        
        let doneButton = UIButton(type: .system)
        doneButton.frame.origin.x = 8
        doneButton.frame.origin.y = wrappedView.center.y / 2
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        doneButton.sizeToFit()
        doneButton.addTarget(self, action: #selector(hideKeyboard), for: .touchUpInside)
        wrappedView.addSubview(doneButton)
        
        view.addSubview(sizeTextField)
    }
    
    // MARK: Configure productQuantityLabel
    
    private func configureQuantityLabel() {
        let viewWidth = view.bounds.width
        
        quantityLabel.frame = CGRect(x: 8,
                                     y: sizeLabel.frame.origin.y + sizeLabel.frame.height + 8,
                                     width: viewWidth / 3,
                                     height: 22)
        quantityLabel.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        quantityLabel.text = "Quantity"
        
        view.addSubview(quantityLabel)
    }
    
    // MARK: Configure productQuantityTextField
    // Add gesture .onTap to quantityTextField
    // Invoke alert controller with quantity textField on textField .touchUpInside
    // Set alert textField value to quantityTextField
    
    private func configureQuantityTextField() {
        let viewWidth = view.bounds.width
        
        quantityTextField.frame = CGRect(x: viewWidth / 8 * 6 - quantityLabel.frame.origin.x,
                                         y: quantityLabel.frame.origin.y,
                                         width: viewWidth / 8 * 2,
                                         height: 22)
        quantityTextField.borderStyle = .roundedRect
        quantityTextField.textAlignment = .center
        quantityTextField.placeholder = "Quantity"
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showQuantityAlert))
        quantityTextField.addGestureRecognizer(gesture)
        
        view.addSubview(quantityTextField)
    }
    
    // MARK: Configure toCartButton
    
    private func configureToCartButton() {
        let viewWidth = view.bounds.width
        
        toCartButton.frame = CGRect(x: 16, y: quantityLabel.frame.origin.y + quantityLabel.frame.height + 16, width: viewWidth - 32, height: 42)
        toCartButton.layer.cornerRadius = 15
        toCartButton.setTitle("to Cart", for: .normal)
        toCartButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        toCartButton.backgroundColor = .systemBlue
        toCartButton.tintColor = .white
        toCartButton.addTarget(self, action: #selector(moveToCheckout), for: .touchUpInside)
        
        view.addSubview(toCartButton)
    }
    
    // MARK: shareButtonTapped
    // Call UIActivityViewController for share
    
    @objc private func shareButtonTapped(sender: Any) {
        let item = "some message"
        
        let activityViewController = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        DispatchQueue.main.async {
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    // MARK: segmentedControlChanged
    // Change product color and product image
    
    @objc private func selectColor(sender: UISegmentedControl) {
        let segmentIndex = sender.selectedSegmentIndex
        guard let segmentTitle = sender.titleForSegment(at: segmentIndex) else { return }
        productImage.image = UIImage(named: "NB\(segmentTitle).jpg")
        let senderIndex = sender.selectedSegmentIndex
        self.product.color = sender.titleForSegment(at: senderIndex)
    }
    
    // MARK: showQuantityAlert
    // Call UIAlertViewController with textField to set quantity of a product
    
    @objc private func showQuantityAlert() {
        let alertController = UIAlertController(title: "Quantity", message: "Enter desirable quantity and press OK", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter quantity"
            textField.keyboardType = .numberPad
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            guard let quantityTextField = alertController.textFields?[0] else { return }
            if quantityTextField.text != "" {
                self.quantityTextField.text = quantityTextField.text
            } else {
                print("Empty text field")
            }
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: moveToCheckout
    // Add Item to cart
    // Call UIAlertViewController to change continue choice or move to CartViewController
    
    @objc private func moveToCheckout() {
        let alertController = UIAlertController(title: "Successful", message: "Move to Cart or continue shopping?", preferredStyle: .alert)
        // Set product values
        
        self.product.color = colorSegmentedControl.titleForSegment(at: colorSegmentedControl.selectedSegmentIndex)
        self.product.size = sizeTextField.text
        self.product.quantity = quantityTextField.text
        
        let toCartAction = UIAlertAction(title: "to Cart", style: .default) { (action) in
            CartViewController.configureCart(with: self.product)
            self.navigationController?.pushViewController(CartViewController(), animated: true)
        }
        let continueAction = UIAlertAction(title: "Continue", style: .default) { (action) in
            CartViewController.configureCart(with: self.product)
        }
        alertController.addAction(toCartAction)
        alertController.addAction(continueAction)
        
        if sizeTextField.text != nil && quantityTextField.text != nil {
            present(alertController, animated: true, completion: nil)
        }
    }
}

