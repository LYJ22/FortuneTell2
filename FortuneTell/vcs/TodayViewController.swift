//
//  TodayViewController.swift
//  FortuneTell
//
//  Created by 22 on 12/19/24.
//

import UIKit





class TodayViewController: UIViewController {
    var name: String?
    var gender: String?
    var dateType: String?
    var date: String?
    var time: String?

    var fortuneList: [String] = []

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        self.labelSubTitle.text = "\(name!)님의 오늘의 운세입니다."
            self.backImage.image = UIImage(named: "roll")
        labelContent.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.transition(with: self.backImage,
                                  duration: 1.5,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                      self.backImage.image = UIImage(named: "back")
                                  }, completion: nil)
            }
        
        labelContent.fadeIn()
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
        loadFortuneFromCSV()
        
        if let tabBarItems = tabBarController?.tabBar.items {
            for item in tabBarItems {
                item.image = item.image?.withRenderingMode(.alwaysOriginal)
            }
        }
        
        self.backImage.image = UIImage(imageLiteralResourceName: "roll")
        labelTitle.font = UIFont(name: "NotoSerifKR-SemiBold", size: 28)
        
        labelSubTitle.font = UIFont(name: "NotoSerifKR-Medium", size: 22)
        
        labelContent.font = UIFont(name: "NotoSerifKR-Light", size: 17)
        labelContent.text = """
츄르 님의 초년운세 흐름은 21세까지 적용이 됩니다. 어려서부터 인기가 많은 사주입니다. 여성에게는 깍쟁이 같다는 소리를 자주 듣겠지만 남성들에게는 꽤나 어필하는 스타일이지요. 10대 중반에 성격이 완성 되는데 이 때 함께한 친구가 평생의 지기가 될 것입니다. 20대 초반에 사랑을 하게 될 것이나 결과가 좋지는 않습니다. 학업성적은 보통보다 좀 나은 편에 해당합니다. 성격은 우유부단하다는 소리를 듣기는 하지만 남이 보지 못하는 내적인 결단력이 있습니다. 20대 중 후반 직장생활을 통해 새로운 전기가 마련되는 운세입니다.
        츄르 님의 초년운세 흐름은 21세까지 적용이 됩니다. 어려서부터 인기가 많은 사주입니다. 여성에게는 깍쟁이 같다는 소리를 자주 듣겠지만 남성들에게는 꽤나 어필하는 스타일이지요. 10대 중반에 성격이 완성 되는데 이 때 함께한 친구가 평생의 지기가 될 것입니다. 20대 초반에 사랑을 하게 될 것이나 결과가 좋지는 않습니다. 학업성적은 보통보다 좀 나은 편에 해당합니다. 성격은 우유부단하다는 소리를 듣기는 하지만 남이 보지 못하는 내적인 결단력이 있습니다. 20대 중 후반 직장생활을 통해 새로운 전기가 마련되는 운세입니다.
"""

    }
    
    private func parseCSVAt(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let dataEncoded = String(data: data, encoding: .utf8)
            if let dataArr = dataEncoded?.components(separatedBy: "\n").map({String($0)}) {
                print("Parsed data: \(dataArr)")
                //self.fortuneList = dataArr.compactMap({ FortuneModel(value: $0) })
                
                //let fortune = self.fortuneList.randomElement()
                
                //if let fortune = fortune {
                //    earlyLabel.text = fortune.earlyLife
                //}
                
            }
        } catch {
            print("Error reading CSV file")
        }
    }
   
    private func loadFortuneFromCSV() {
        print("loading...")
        let path = Bundle.main.path(forResource: "today", ofType: "csv")!
        parseCSVAt(url: URL(fileURLWithPath: path))
    }
}
