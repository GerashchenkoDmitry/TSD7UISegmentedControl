//
//  ProductSizeTextField.swift
//  TSD7UISegmentedControl
//
//  Created by Дмитрий Геращенко on 16.02.2022.
//

import UIKit

final class SizeTextField: UITextField {
    let productSizes: [Int] = Array(7...11)
}

extension SizeTextField: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        productSizes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        String(productSizes[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text = String(productSizes[row])
    }
}
