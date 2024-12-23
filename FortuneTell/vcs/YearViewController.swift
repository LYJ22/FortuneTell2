//
//  YearViewController.swift
//  FortuneTell
//
//  Created by 22 on 12/19/24.
//

import UIKit

extension UIView {
    public func fadeIn(duration: TimeInterval = 1.5, delay: TimeInterval = 1.0, completion: ((Bool) -> Void)? = nil) {
        self.alpha = 0.0
        self.isHidden = false
        UIView.animate(withDuration: duration, delay: delay, options: .transitionFlipFromBottom
, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }

}


class YearViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var fortuneList: [FortuneModel] = []
    var name: String?
    var gender: String?
    var dateType: String?
    var date: String?
    var time: String?
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var yearTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var labelTitle: UILabel!
    
    
    //월 선택
    let month: [String] = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return month.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return month[row]
    }
    

    
    
   func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
          let label = UILabel()
          label.text = month[row]
          label.textAlignment = .center
          
       label.font = UIFont(name: "NotoSerifKR-SemiBold", size: 20)
          return label
   }
   
    
    


    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.imageView.image = UIImage(named: "roll")
            self.contentView.isHidden = true
        self.labelTitle.text = "월별 신년운세"
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name {
            print("넘어온 값 name: \(name)")
        }
        if let gender = gender {
            print("넘어온 값 gender: \(gender)")
        }
        if let dateType = dateType {
            print("넘어온 값 dateType: \(dateType)")
        }
        if let date = date {
            print("넘어온 값 date: \(date)")
        }
        if let time = time {
            print("넘어온 값 time: \(time)")
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        self.imageView.image = UIImage(imageLiteralResourceName: "roll")
        contentView.isHidden = true
        
        
        yearTitle.font = UIFont(name: "NotoSerifKR-SemiBold", size: 28)
        
        labelTitle.font = UIFont(name: "NotoSerifKR-Medium", size: 22)
        
        labelContent.font = UIFont(name: "NotoSerifKR-Light", size: 17)
        
//        for family in UIFont.familyNames {
//            print("Font family: \(family)")
//            for font in UIFont.fontNames(forFamilyName: family) {
//                print("Font name: \(font)")
//            }
//        }
        if let tabBarItems = tabBarController?.tabBar.items {
            for item in tabBarItems {
                item.image = item.image?.withRenderingMode(.alwaysOriginal)
            }
        }
        loadFortuneFromCSV()
        
    }
    


    @IBAction func selectMonth(_ sender: UIButton) {
        
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let selectedMonth = month[selectedRow]
        
        labelTitle.text = "\(name!)님의 \(selectedMonth) 신년운세입니다."
        
        guard let dateString = date else {
            labelContent.text = "생년월일이 설정되지 않았습니다."
            return
        }
        
        if let fortuneIndex = calculateFortuneIndex(from: dateString) {
            if fortuneIndex >= 0 && fortuneIndex < fortuneList.count {
                let fortune = fortuneList[fortuneIndex]
                labelContent.text = "\(selectedMonth): \(fortune.months[selectedRow])"
            } else {
                labelContent.text = "해당 월에 대한 운세 데이터가 없습니다."
            }
        } else {
            labelContent.text = "유효한 생년월일이 아닙니다."
        }
        
        contentView.isHidden = false
        self.imageView.image = UIImage(named: "roll")
        
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.transition(with: self.imageView,
                                         duration: 1.5,
                                         options: .transitionCrossDissolve,
                                         animations: {
                                             self.imageView.image = UIImage(named: "back")
                                         }, completion: nil)
                   }
        contentView.fadeIn()
    }
    
    func calculateFortuneIndex(from dateString: String) -> Int? {
        let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "yyyy-MM-dd"  // 날짜 형식 설정 (예: 2024-12-23)
             
             guard let date = dateFormatter.date(from: dateString) else {
                 print("Invalid date format")
                 return nil
             }
             
             let calendar = Calendar.current
             let year = calendar.component(.year, from: date)
             let month = calendar.component(.month, from: date)
             let day = calendar.component(.day, from: date)
             
             // 년, 월, 일을 합산한 값으로 운세 인덱스를 계산
             let total = year + month + day
             return total % fortuneList.count
    }
    
    private func parseCSVAt(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let dataEncoded = String(data: data, encoding: .utf8)
            if let dataArr = dataEncoded?.components(separatedBy: "\n")
                .map({$0.components(separatedBy: ",")}) {
                print("Parsed data: \(dataArr)")
                self.fortuneList = dataArr.compactMap({
                    FortuneModel(value: $0) })
                }
            
        } catch {
            print("Error reading CSV file")
        }
    }
    
    private func loadFortuneFromCSV() {
        print("loading...")
        let path = Bundle.main.path(forResource: "month", ofType:"csv")!
        parseCSVAt(url: URL(fileURLWithPath: path))
    }
    
    
    struct FortuneModel: Codable {
        var months: [String]
        init?(value: [String]) {
            guard value.count == 12 else { return nil }
            self.months = value
        }
    }

}
