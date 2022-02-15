//
//  CSLogButton.swift
//  MyMemory
//
//  Created by 박힘찬 on 2022/01/14.
//

import UIKit

public enum CSLogType: Int {
    case basic // 기본 로그 타입
    case title // 버튼의 타이틀을 출력
    case tag // 버튼의 태그값을 출력
}
public class CSLogButton: UIButton {
    // 로그 출력 타입 프로퍼티
    public var logType: CSLogType = .basic
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        // 버튼에 스타일 적용
        self.setBackgroundImage(UIImage(named: "button-bg.png"), for: .normal)
        self.tintColor = .blue
        // 버튼의 클릭 이벤트에 logging(_:) 메소드를 연결
        self.addTarget(self, action: #selector(logging(_:)), for: .touchUpInside)
    }
    // 로그를 출력하는 액션 메소드
    @objc func logging(_ sender: UIButton) {
        switch self.logType {
        case .basic: // 단순 로그 출력
            NSLog("버튼이 클릭되었습니다.")
        case .title: // 버튼의 타이틀 출력
            let btnTitle = sender.titleLabel?.text ?? "타이틀 없는" // ①
            NSLog("\(btnTitle) 버튼이 클릭되었습니다.")
        case .tag: // 로그 버튼의 태그를 출력
            NSLog("\(sender.tag) 버튼이 클릭되었습니다.")
        }
    }
}
