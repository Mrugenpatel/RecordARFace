//
//  RARFNumberKeyboardView.swift
//  RecordARFace
//
//  Created by 永田大祐 on 2019/02/03.
//  Copyright © 2019 永田大祐. All rights reserved.
//

import UIKit

enum Calculator: Int { case plus, minus, division, multiplication }

class RARFNumberKeyboardView: UIView {

    @IBOutlet weak var one: RARFNumberButton!
    @IBOutlet weak var two: RARFNumberButton!
    @IBOutlet weak var three: RARFNumberButton!
    @IBOutlet weak var four: RARFNumberButton!
    @IBOutlet weak var five: RARFNumberButton!
    @IBOutlet weak var six: RARFNumberButton!
    @IBOutlet weak var seven: RARFNumberButton!
    @IBOutlet weak var eight: RARFNumberButton!
    @IBOutlet weak var nine: RARFNumberButton!
    @IBOutlet weak var zero: RARFNumberButton!
    @IBOutlet weak var minus: RARFNumberButton!
    @IBOutlet weak var plus: RARFNumberButton!
    @IBOutlet weak var multiplication: RARFNumberButton!
    @IBOutlet weak var divite: RARFNumberButton!
    @IBOutlet weak var enter: RARFNumberButton!
    @IBOutlet weak var claer: RARFNumberButton!
    @IBOutlet weak var allClaer: RARFNumberButton!
    @IBOutlet weak var textLabel: UILabel!

    private var plusNumber = ""
    private var total: String?
    private var calculatorNum: Int?
    private var totalNumber: Float?


    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }

    func loadNib() {
        let bundle = Bundle(for: RARFNumberKeyboardView.self)
        let view = bundle.loadNibNamed("RARFNumberKeyboardView", owner: self, options: nil)?.first as! UIView
        view.frame = UIScreen.main.bounds
        self.addSubview(view)
    }

    func originTextField(rect: CGRect) {

        var rectFrame = rect
        rectFrame.origin.y -= UINavigationController.init().navigationBar.frame.height + UIApplication.shared.statusBarFrame.height

        if one.frame.contains(rectFrame) { number(index: 1) }
        if two.frame.contains(rectFrame) { number(index: 2) }
        if three.frame.contains(rectFrame) { number(index: 3) }
        if four.frame.contains(rectFrame) { number(index: 4) }
        if five.frame.contains(rectFrame) { number(index: 5) }
        if six.frame.contains(rectFrame) { number(index: 6) }
        if seven.frame.contains(rectFrame) { number(index: 7) }
        if eight.frame.contains(rectFrame) { number(index: 8) }
        if nine.frame.contains(rectFrame) { number(index: 9) }
        if zero.frame.contains(rectFrame) { number(index: 0) }

        if plus.frame.contains(rectFrame) { calculatorValue(index: Calculator.plus.rawValue) }
        if minus.frame.contains(rectFrame) { calculatorValue(index: Calculator.minus.rawValue) }
        if divite.frame.contains(rectFrame) { calculatorValue(index: Calculator.division.rawValue) }
        if multiplication.frame.contains(rectFrame) { calculatorValue(index: Calculator.multiplication.rawValue) }

        if claer.frame.contains(rectFrame) {
            plusNumber = String(textLabel.text!.dropLast(1))
            textLabel.text = String(textLabel.text!.dropLast(1))
        }

        if allClaer.frame.contains(rectFrame) {
            total = nil
            plusNumber = ""
            textLabel.text! = ""
        }

        if enter.frame.contains(rectFrame) {
            if total != nil {
                let indexNumber = calculator(index: calculatorNum!,
                                             txtNumber:  Float(total!)!,
                                             txtNumber2: Float(textLabel.text!)!)
                total = nil
                plusNumber = ""
                textLabel.text! = indexNumber.description
            }
        }
    }

    private func number(index: Int) {
        plusNumber += index.description
        textLabel.text = plusNumber
    }

    private func calculatorValue(index: Int) {
        if total != nil {
            totalNumber = calculator(index: index,
                                     txtNumber:  Float(total!)!,
                                     txtNumber2: Float(textLabel.text!)!)
            total = totalNumber?.description
            textLabel.text = totalNumber?.description
        } else {
            total = textLabel.text
        }
          plusNumber = ""
          calculatorNum = index
    }

    private func calculator(index: Int, txtNumber: Float, txtNumber2: Float) -> Float {
        switch index {
        case Calculator.plus.rawValue: return txtNumber + txtNumber2
        case Calculator.minus.rawValue: return txtNumber - txtNumber2
        case Calculator.division.rawValue: return txtNumber / txtNumber2
        case Calculator.multiplication.rawValue: return txtNumber * txtNumber2
        default:
            return Float()
        }
    }
}
