//
//  MainViewController.swift
//  FortuneTell
//
//  Created by lyj on 12/19/24.
//

import UIKit

let time = ["모름", "23시 30분 ~ 1시 29분", "1시 30분 ~ 3시 29분", "3시 30분 ~ 5시 29분",
            "5시 30분 ~ 7시 29분", "7시 30분 ~ 9시 29분", "9시 30분 ~ 11시 29분",
            "11시 30분 ~ 13시 29분", "13시 30분 ~ 15시 29분", "15시 30분 ~ 17시 29분",
            "17시 30분 ~ 19시 29분", "19시 30분 ~ 21시 29분", "21시 30분 ~ 23시 29분"]
let gender = ["남성", "여성"]
let dateType = ["음력", "양력"]
var selectedTime = time.first
var date = ""

class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var textViewName: UITextField!
    @IBOutlet weak var segmentMW: UISegmentedControl!
    @IBOutlet weak var segmentDateType: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var picker: UIPickerView!
    //font변경
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelMW: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    
    @IBOutlet weak var buttonFont: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //font
        labelName.font = UIFont(name: "NotoSerifKR-SemiBold", size: 17)
        labelMW.font = UIFont(name: "NotoSerifKR-SemiBold", size: 17)
        labelDate.font = UIFont(name: "NotoSerifKR-SemiBold", size: 17)
        labelTime.font = UIFont(name: "NotoSerifKR-SemiBold", size: 17)
        buttonFont.titleLabel?.font = UIFont(name: "NotoSerifKR-SemiBold", size: 17)
        
        // 네비게이션 바 배경색, 크기 설정
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 255.0/255.0, green: 158.0/255.0, blue: 7.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = .black
        //navigationController?.additionalSafeAreaInsets.top = 5
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        picker.delegate = self
        picker.dataSource = self
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        date = dateformatter.string(from: Date())
    }
    
    
    @IBAction func buttonFortune(_ sender: UIButton) {
        
        guard let name = textViewName.text, !name.isEmpty else{
            print("오류")
            let alert = UIAlertController(title: "입력 오류", message: "값을 입력해 주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        

    }
    
    // date picker 날짜 선택
    @IBAction func datePick(_ sender: UIDatePicker) {
        let datePickerView = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        date = formatter.string(from: datePickerView.date)
    }
    
    
    // picker 시간 선택
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return time.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return time[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTime = time[row]
        print(selectedTime!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let tabBarController = segue.destination as? UITabBarController {
            if let viewControllers = tabBarController.viewControllers {
                for viewController in viewControllers {
                    if let firstChildVC = viewController as? TodayViewController {
                        firstChildVC.name = textViewName.text!
                        firstChildVC.gender = gender[segmentMW.selectedSegmentIndex]
                        firstChildVC.dateType = dateType[segmentDateType.selectedSegmentIndex]
                        firstChildVC.date = date
                        firstChildVC.time = selectedTime!
                    }
                    else if let secondChildVC = viewController as? YearViewController {
                        secondChildVC.name = textViewName.text!
                        secondChildVC.gender = gender[segmentMW.selectedSegmentIndex]
                        secondChildVC.dateType = dateType[segmentDateType.selectedSegmentIndex]
                        secondChildVC.date = date
                        secondChildVC.time = selectedTime!
                    }
                    else if let thirdChildVC = viewController as? LifeViewController {
                        thirdChildVC.name = textViewName.text!
                        thirdChildVC.gender = gender[segmentMW.selectedSegmentIndex]
                        thirdChildVC.dateType = dateType[segmentDateType.selectedSegmentIndex]
                        thirdChildVC.date = date
                        thirdChildVC.time = selectedTime!
                    }
                }
            }
        }
    }
}

