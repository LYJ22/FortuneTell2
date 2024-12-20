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

class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var textViewName: UITextField!
    @IBOutlet weak var segmentMW: UISegmentedControl!
    @IBOutlet weak var segmentDateType: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
    }
    
    
    @IBAction func buttonFortune(_ sender: UIButton) {
        let gen = gender[segmentMW.selectedSegmentIndex]
        let dType = dateType[segmentDateType.selectedSegmentIndex]
        print(textViewName.text)
        print(gen)
        print(dType)
        print(selectedTime!)
        
        if let name = textViewName.text, !name.isEmpty, let tabBarController = self.tabBarController {
            
            if let dayVC = tabBarController.viewControllers?[0] as? TodayViewController{
                
            }
            if let yearVC = tabBarController.viewControllers?[1] as? YearViewController{
                
            }
            /*
             
                평생 운세
             
             */
        }else{
            /*print("오류")
            let alert = UIAlertController(title: "입력 오류", message: "값을 입력해 주세요.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)*/
        }
    }
    
    
    
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
    
}

