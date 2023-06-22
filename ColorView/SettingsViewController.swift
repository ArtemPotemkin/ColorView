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
    
    var color: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorizedView.layer.cornerRadius = 15
        setupSliders()
        setupValueLabels()
        setupColorizedView()
    }
    
    // MARK: - IBActions
    @IBAction func redSliderAction() {
        redValueLabel.text = string(from: redSlider)
        setupColorizedView()
    }
    
    @IBAction func greenSliderAction() {
        greenValueLabel.text = string(from: greenSlider)
        setupColorizedView()
    }
    
    @IBAction func blueSliderAction() {
        blueValueLabel.text = string(from: blueSlider)
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


}

