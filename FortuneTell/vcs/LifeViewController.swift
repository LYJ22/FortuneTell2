//
//  TodayViewController.swift
//  FortuneTell
//
//  Created by 22 on 12/19/24.
//

import UIKit

class LifeViewController: UIViewController {
    var fortuneList: [FortuneModel] = []
    var name: String?
    var gender: String?
    var dateType: String?
    var date: String?
    var time: String?
    
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var labelSubtitle: UILabel!
    
    @IBOutlet weak var laterLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var earlyLabel: UILabel!
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
        
        titleLabel.font = UIFont(name: "NotoSerifKR-SemiBold", size: 28)
        labelSubtitle.font = UIFont(name: "NotoSerifKR-Medium", size: 22)
        labelSubtitle.text = "\(name!)님의 평생운세입니다."
        // 탭바 아이템의 이미지 색상 변경 방지
        if let tabBarItems = tabBarController?.tabBar.items {
            for item in tabBarItems {
                item.image = item.image?.withRenderingMode(.alwaysOriginal)
            }
        }
    
        loadFortuneFromCSV()
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        animationView.isHidden = true
        animationView.fadeInWithFlip()
            
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
            return total % fortuneList.count  // fortuneList.count을 넘지 않도록 나머지를 사용
        }
    
    private func parseCSVAt(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let dataEncoded = String(data: data, encoding: .utf8)
            if let dataArr = dataEncoded?.components(separatedBy: "\n").map({$0.components(separatedBy: ",")}) {
                print("Parsed data: \(dataArr)")
                self.fortuneList = dataArr.compactMap({ FortuneModel(value: $0) })
                
                guard let dateString = date else {
                    print("생년월일이 설정되지 않았습니다.")
                    return
                }
                
                if let fortuneIndex = calculateFortuneIndex(from: dateString) {
                    if fortuneIndex >= 0 && fortuneIndex < fortuneList.count {
                        let fortune = fortuneList[fortuneIndex]
                        earlyLabel.font = UIFont(name: "NotoSerifKR-Light", size: 17)
                        middleLabel.font = UIFont(name: "NotoSerifKR-Light", size: 17)
                        laterLabel.font = UIFont(name: "NotoSerifKR-Light", size: 17)
                        earlyLabel.text = fortune.earlyLife
                        middleLabel.text = fortune.middleLife
                        laterLabel.text = fortune.laterLife
                    } else {
                        print("해당 인덱스의 운세 데이터가 없습니다")
                    }
                }
            }
        } catch {
            print("Error reading CSV file")
        }
    }
    
    private func loadFortuneFromCSV() {
        print("loading...")
        let path = Bundle.main.path(forResource: "life", ofType: "csv")!
        parseCSVAt(url: URL(fileURLWithPath: path))
    }
    
    struct FortuneModel: Codable {
        var earlyLife: String
        var middleLife: String
        var laterLife: String
        
        init?(value: [String]) {
            guard value.count == 3 else { return nil }
            earlyLife = value[0]
            middleLife = value[1]
            laterLife = value[2]
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
