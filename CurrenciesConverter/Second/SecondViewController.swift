//
//  SecondViewController.swift
//  CurrenciesConverter
//
//  Created by Rita on 29.12.2021.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {
    
    var picker = UIPickerView()
    var topCurrencyCc = UILabel()
    var topCurrencyRate = UITextField()
    var bottomCurrencyCc = UILabel()
    var bottomCurrencyRate = UITextField()
    
    var firstRate = Double()
    var secondRate = Double()
    
    
    let pickerData: [Model]
    
    init(pickerData: [Model]) {
        self.pickerData = pickerData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        topCurrencyRate.delegate = self
        bottomCurrencyRate.isUserInteractionEnabled = false
        topCurrencyRate.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        setupSecondScreen()
        firstRate = pickerData[0].rate
        secondRate = pickerData[0].rate
        
    }
    
    func calculate(rate1: Double, rate2: Double, value: Double) -> Double {
        let result = rate1 * value / rate2
        return result
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        
        guard let value = Double(topCurrencyRate.text ?? "") else {
            bottomCurrencyRate.text = "\(0)"
            return
        }
        let result = calculate(rate1: firstRate, rate2: secondRate, value: value)
        let rate = round(result * 100)/100
        bottomCurrencyRate.text = "\(rate)"
    }
    
    func setupSecondScreen() {
        view.backgroundColor = .white
        navigationItem.title = "Converter"
        topCurrencyRate.keyboardType = .numberPad
        
        view.addSubview(topCurrencyCc)
        topCurrencyCc.text = pickerData.first?.cc
        topCurrencyCc.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(107)
        }
        view.addSubview(topCurrencyRate)
        topCurrencyRate.borderStyle = .roundedRect
        topCurrencyRate.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(100)
            make.width.equalTo(80)
        }
        
        view.addSubview(picker)
        picker.snp.makeConstraints { (make) in
            make.top.equalTo(topCurrencyRate.snp.bottom)
            make.right.left.equalToSuperview()
            make.height.equalTo(100)
        }
        
        view.addSubview(bottomCurrencyCc)
        bottomCurrencyCc.text = pickerData.first?.cc
        bottomCurrencyCc.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(15)
            make.top.equalTo(picker.snp.bottom).inset(-7)
        }
        
        view.addSubview(bottomCurrencyRate)
        bottomCurrencyRate.borderStyle = .roundedRect
        bottomCurrencyRate.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(15)
            make.top.equalTo(picker.snp.bottom)
            make.width.equalTo(80)
        }
    }
}

extension SecondViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
}

extension SecondViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].cc
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            topCurrencyCc.text = pickerData[row].cc
            firstRate = pickerData[row].rate
            print(firstRate)
        } else {
            bottomCurrencyCc.text = pickerData[row].cc
            secondRate = pickerData[row].rate
        }
    }
}
