//
//  MemoReadVC.swift
//  MyMemory
//
//  Created by 박힘찬 on 2021/09/30.
//

import UIKit

class MemoReadVC: UIViewController {
    // 콘텐츠 데이터를 저장하는 변수
    var param: MemoData?
    
    @IBOutlet var subject: UILabel! // 메모 제목
    @IBOutlet var contents: UILabel! // 메모 내용
    @IBOutlet var img: UIImageView! // 이미지
    
    override func viewDidLoad() {
        // 1. 제목과 내용, 이미지를 출력
        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
        // 2. 날짜 포맷 변환
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formatter.string(from: (param?.regdate)!)
        // 3. 내비게이션 타이틀에 날짜를 표시
        self.navigationItem.title = dateString
    }
}
