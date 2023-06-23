//
//  ViewController.swift
//  ColorView
//
//  Created by Артём Потёмкин on 30.05.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var colorizedView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var color: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorizedView.layer.cornerRadius = 15
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        setupSliders()
        setupValueLabels()
        setupTextFieldText()
        setupColorizedView()
        setupToolBar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction func redSliderAction() {
        redValueLabel.text = string(from: redSlider)
        redTextField.text = redValueLabel.text
        setupColorizedView()
    }
    
    @IBAction func greenSliderAction() {
        greenValueLabel.text = string(from: greenSlider)
        greenTextField.text = greenValueLabel.text
        setupColorizedView()
    }
    
    @IBAction func blueSliderAction() {
        blueValueLabel.text = string(from: blueSlider)
        blueTextField.text = blueValueLabel.text
        setupColorizedView()
    }
    
    @IBAction func doneButtonTapped() {
        delegate.setNewBackgroundColor(color: colorizedView.backgroundColor ?? .cyan)
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func setupSliders() {
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .systemBlue
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
    }
    
    private func setupColorizedView() {
        colorizedView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setupValueLabels() {
        redValueLabel.text = string(from: redSlider)
        greenValueLabel.text = string(from: greenSlider)
        blueValueLabel.text = string(from: blueSlider)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setupTextFieldText() {
        redTextField.text = redValueLabel.text
        greenTextField.text = greenValueLabel.text
        blueTextField.text = blueValueLabel.text
    }
    
    private func setupToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let leftSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: .none,
            action: .none
        )
        
        let button = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: .none,
            action: #selector(hideKeyboard)
        )
        
        toolBar.setItems([leftSpace, button], animated: true)
        
        [redTextField,
         greenTextField,
         blueTextField].forEach { $0?.inputAccessoryView = toolBar}
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextViewDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberFloat = Float(newValue) else { return }
        if textField == redTextField {
            redSlider.value = numberFloat
            redValueLabel.text = string(from: redSlider)
        } else if textField == greenTextField {
            greenSlider.value = numberFloat
            greenValueLabel.text = string(from: greenSlider)
        } else {
            blueSlider.value = numberFloat
            blueValueLabel.text = string(from: blueSlider)
        }
        setupColorizedView()
    }
}
