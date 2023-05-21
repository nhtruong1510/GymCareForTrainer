//
//  InputPickerView.swift
//
//

import UIKit

class InputPickerView: BaseView {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var titleView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var inputTextField: CustomUITextField!
    @IBOutlet private weak var alertView: UIView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet private weak var alertLabel: UILabel!
    @IBOutlet private weak var showPopupButton: UIButton!
    @IBOutlet private weak var clearDataButton: UIButton!
    
    var editingCallBack: ((String?) -> (Void))?
    var onClickShowPopup: (() -> (Void))?
    var endEditingMonthYearCallBack: ((Int?, Int?) -> (Void))?
    var onClickClearData: (() -> (Void))?

//    private let monthYearPicker = MonthYearPickerView(frame: CGRect(x: 0, y: 0, width: Constants.WIDTH_SCREEN, height: 216))
//    private let yearPicker = YearPickerView(frame: CGRect(x: 0, y: 0, width: Constants.WIDTH_SCREEN, height: 216))
//    private let quarterPicker = QuarterlyPickerView(frame: CGRect(x: 0, y: 0, width: Constants.WIDTH_SCREEN, height: 216))
//    private let monthPicker = MonthPickerView(frame: CGRect(x: 0, y: 0, width: Constants.WIDTH_SCREEN, height: 216))
//    private let monthPickerView = ChooseMonthPickerView(frame: CGRect(x: 0, y: 0, width: Constants.WIDTH_SCREEN, height: 216))
    private let datePicker = UIDatePicker()

    var value: String? {
        set(value) {
            inputTextField.text = value
//            switch TypeDate(rawValue: typeDate) {
//            case .chooseMonth:
//                guard let date = dateFormat(timerString: value, format: Constants.MONTH_STYLE_STRING) else {return}
//                let dateString = dateFormat(timerString: date, format: Constants.MONTH_STYLE_STRING)
//                monthPickerView.maxYear = castToInt(dateString?.components(separatedBy: "/").last)
//            default:
//                break
//            }
        }
        get {
            if castToString(inputTextField.text).isEmpty {
                return nil
            }
            return inputTextField.text
        }
    }

    var monthChoose: Date? {
        didSet {
//            if let monthChoose = monthChoose, monthChoose > Date() {
//                monthPickerView.date = Date()
//            } else {
//                monthPickerView.date = monthPickerView.date
//            }
        }
    }

    var year: Int? = castToInt(Date().toString(Constants.YEAR_STRING))
    var quarter: Int? {
        didSet {
//            switch TypeDate(rawValue: typeDate) {
//            case .month:
//                monthPicker.quarter = castToInt(quarter)
//            default: break
//            }
        }
    }

    var month: Int? = castToInt(Date().toString(Constants.MONTH_STRING))

    @IBInspectable
    var title: String? {
        didSet {
            titleLabel.text = title
            titleView.isHidden = title == nil
        }
    }

    @IBInspectable
    var number: String? {
        didSet {
            alertLabel.text = number
            alertView.isHidden = number == nil
        }
    }
    
    @IBInspectable
    var timeDefault: String? {
        didSet {
            inputTextField.text = timeDefault
        }
    }

    @IBInspectable
    var isDate: Bool = false {
        didSet {
            if isDate {
                showTimePicker()
            }
            showPopupButton.isHidden = isDate
            inputTextField.isUserInteractionEnabled = isDate
        }
    }

    @IBInspectable
    var isHaveImage: Bool = false {
        didSet {
            avatarView.isHidden = !isHaveImage
        }
    }
    
    @IBInspectable
    var hiddenClearButton: Bool = true

    @IBInspectable
    var isNote: Bool = false {
        didSet {
            if isNote {
                guard !castToString(titleLabel.text).contains(" *") else { return }
                let title = castToString(titleLabel.text) + " *"
                let amountText = NSMutableAttributedString.init(string: title)
                let range = (title as NSString).range(of: " *")
                amountText.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                          NSAttributedString.Key.foregroundColor: UIColor.red],
                                         range: range)
                titleLabel.attributedText = amountText
            } else {
                titleLabel.text = titleLabel.text?.replacingOccurrences(of: " *", with: "")
            }
        }
    }

    @IBInspectable
    var editingIsAllow: Bool = true {
        didSet {
            inputTextField.isUserInteractionEnabled = editingIsAllow
            inputTextView.backgroundColor = editingIsAllow ? UIColor.white : UIColor.lightGray
            inputTextField.textColor = editingIsAllow ? .black : .darkGray

        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        Bundle.main.loadNibNamed("InputPickerView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func showTimePicker() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.HOUR_STRING
        let date = dateFormatter.date(from: castToString(inputTextField.text))
        datePicker.locale = Locale(identifier: "vi")
        datePicker.date = date ?? Date()
        datePicker.datePickerMode = .time
        if #available(iOS 13.4, *){
            datePicker.preferredDatePickerStyle = .wheels
        }
        // add toolbar to textField
        inputTextField.inputAccessoryView = setToolbar()

        // add datepicker to textField
        inputTextField.inputView = datePicker
        dateFormatter.dateFormat = Constants.HOUR_STRING
        inputTextField.text = dateFormatter.string(from: datePicker.date)
    }

    private func showMonthYearPicker() {
//        monthYearPicker.locale = Locale(identifier: "vi")
//        monthYearPicker.date = Date()
//        inputTextField.inputAccessoryView = setToolbar()
//        inputTextField.inputView = monthYearPicker
//        inputTextField.text = Date().toString(Constants.MONTH_STYLE_STRING)
    }

    func setMonthYearPicker(monthInt: Int?, yearInt: Int?) {
//        self.month = monthInt
//        self.year = yearInt
//        monthYearPicker.month = monthInt
//        monthYearPicker.year = yearInt
//        var year: String
//        if yearInt == nil {
//            year = castToString(Date().toString(Constants.YEAR_STRING))
//        } else {
//            year = castToString(yearInt)
//        }
//        let month = castToInt(monthInt).setZeroToHead()
//        monthYearPicker.date = "\(month)/\(year)".formatToDate(Constants.MONTH_STYLE_STRING)
//        inputTextField.text = month + "/" + year
    }

    func setQuarterPicker(quarterInt: Int?, yearInt: Int?) {
//        self.quarter = quarterInt
//        self.year = yearInt
//        quarterPicker.quarter = self.quarter
//        quarterPicker.year = yearInt
//        quarterPicker.quarterString = "Quý " + castToString(quarterInt)
//        let date = Calendar.current.date(from: DateComponents(year: castToInt(yearInt), month: 2))
//        quarterPicker.date = date ?? Date()
//        var year: String
//        if yearInt == nil {
//            year = castToString(Date().toString(Constants.YEAR_STRING))
//        } else {
//            year = castToString(yearInt)
//        }
//        inputTextField.text = quarterPicker.quarterString + "/" + year
    }

    func setMonthYearForQuarterPicker(monthInt: Int?, yearInt: Int?, quarter: Int?) {
//        self.quarter = quarter
//        self.month = monthInt
//        self.year = yearInt
//        var year: String
//        if yearInt == nil {
//            year = castToString(Date().toString(Constants.YEAR_STRING))
//        } else {
//            year = castToString(yearInt)
//        }
//        let month = castToInt(monthInt).setZeroToHead()
//        inputTextField.text = month + "/" + year
    }

    private func showYearPicker() {
//        yearPicker.date = Date()
//        inputTextField.inputAccessoryView = setToolbar()
//        inputTextField.inputView = yearPicker
//        inputTextField.text = Date().toString(Constants.YEAR_STRING)
    }
    
    private func showMonthPickerView() {
//        monthPickerView.locale = Locale(identifier: "vi")
//        monthPickerView.date = Date()
//        inputTextField.inputAccessoryView = setToolbar()
//        inputTextField.inputView = monthPickerView
//        inputTextField.text = Date().toString(Constants.MONTH_STRING)
    }

    private func showQuarterPicker() {
//        quarterPicker.date = Date()
//        quarterPicker.locale = Locale(identifier: "vi")
//        inputTextField.inputAccessoryView = setToolbar()
//        inputTextField.inputView = quarterPicker
//        let defaultQuarterStr = castToString(Date().toString(Constants.QUARTER_STYLE_STRING))
//        quarter = castToInt(Date().toString(Constants.QUARTER_STRING))
//        quarterPicker.quarter = quarter
//        inputTextField.text = "Quý " + defaultQuarterStr
    }

    private func showMonthPicker() {
//        inputTextField.inputAccessoryView = setToolbar()
//        inputTextField.inputView = monthPicker
//        quarter = castToInt(Date().toString(Constants.QUARTER_STRING)) - 1
//        let defaultQuarter = castToString(Date().toString(Constants.MONTH_STYLE_STRING))
//        monthPicker.quarter = castToInt(quarter)
//        inputTextField.text = defaultQuarter
    }

    private func setToolbar() -> UIToolbar {
        //TooBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Đồng ý", style: .plain, target: self, action: #selector(self.donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem:  UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Hủy", style: .plain, target: self, action: #selector(self.cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        return toolbar
    }

    @objc private func donedatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.HOUR_STRING
        inputTextField.text = formatter.string(from: datePicker.date)
        if let edttingChanged = editingCallBack {
            edttingChanged(inputTextField.text)
        }
        self.endEditing(true)
    }

    @objc private func cancelDatePicker() {
        self.endEditing(true)
        
    }

    @IBAction private func editingBegin(_ sender: Any) {
//        status = .active
    }

    @IBAction private func editingEnd(_ sender: UITextField) {
//        status = .inactive
//        if !hiddenClearButton {
//            clearDataButton.isHidden = sender.text?.count == 0
//        }
    }

    @IBAction private func onClickShowPopup(_ sender: Any) {
        if let showPopup = onClickShowPopup {
            showPopup()
        }
    }

    @IBAction private func onClickClearData(_ sender: Any) {
        if !hiddenClearButton {
            inputTextField.text = nil
            clearDataButton.isHidden = castToString(inputTextField.text).count == 0
            if let onClick = onClickClearData {
                onClick()
            }
        }
    }

}

class CustomUITextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }

    let inset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 28)

    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: inset)
    }
}
