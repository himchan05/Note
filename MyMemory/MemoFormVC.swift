//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by 박힘찬 on 2021/09/30.
//

import UIKit
class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    var subject: String!
    @IBOutlet var contents: UITextView! // 텍스트 뷰
    @IBOutlet var preview: UIImageView! // 이미지 뷰 (미리보기)
    
    override func viewDidLoad() {
        self.contents.delegate = self // 텍스트 뷰에 대한 delegate 속성을 self로 지정
        // 배경 이미지 설정
        let bgImage = UIImage(named: "memo-background")!
        self.view.backgroundColor = UIColor(patternImage: bgImage)
        // 텍스트 뷰의 기본 속성
        self.contents.layer.borderWidth = 0 // 테두리 두께 0
        self.contents.layer.borderColor = UIColor.clear.cgColor // 테두리 색 투명색
        self.contents.backgroundColor = UIColor.clear // 배경 색상 투명색
        // 줄 간격
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9
        self.contents.attributedText = NSAttributedString(string: "이 문자로 변경 되어 출력됨", attributes: [.paragraphStyle: style])
        self.contents.text = "" // 출력 된 문자를 다시 빈 문자로 초기화
    }
    
    // 저장 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func save(_ sender: Any) {
        // 경고창에 사용될 콘텐츠 뷰 컨트롤러 구성
        let alertView = UIViewController()
        let icon = UIImage(named: "warning-icon-60")
        alertView.view = UIImageView(image: icon)
        alertView.preferredContentSize = CGSize(width: (icon?.size.width)!, height: (icon?.size.height)!)
        // 내용을 입력하지 않았을 경우, 경고한다.
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.setValue(alertView, forKey: "contentViewController")
            self.present(alert, animated: true)
            return
        }
        // MemoData 객체를 생성하고, 데이터를 담는다.
        let data = MemoData()
        
        data.title = self.subject // 제목
        data.contents = self.contents.text // 내용
        data.image = self.preview.image // 이미지
        data.regdate = Date() // 작성 시각
        
        // 앱 델리게이트 객체를 읽어온 다음, memoList 배열에 MemoData 객체를 추가한다.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        // 작성폼 화면을 종료하고, 이전 화면으로 되돌아간다.
        _ = self.navigationController?.popViewController(animated: true)

    }
    /// 카메라 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func pick(_ sender: Any) {
        // 이미지 피커 인스턴스를 생성
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        // 이미지 피커 화면을 표시
        self.present(picker, animated: false)
    }
    // 사용자가 이미지를 선택하면 자동으로 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 선택된 이미지를 미리보기에 출력
        self.preview.image = info[.editedImage] as? UIImage
        
        // 이미지 피커 컨트롤러를 닫는다.
        picker.dismiss(animated: false)
    }
    // 사용자가 텍스트 뷰에 입력하면 자동으로 호출되는 메소드
    func textViewDidChange(_ textView: UITextView) {
        // 내용의 최대 15자리까지 읽어 subject 변수에 저장한다.
        let contents = textView.text as NSString
        let length = ( (contents.length > 15) ? 15 : contents.length )
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        // 내비게이션 타이틀에 표시한다.
        self.navigationItem.title = self.subject
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let bar = self.navigationController?.navigationBar
        
        let ts = TimeInterval(0.3)
        UIView.animate(withDuration: ts) {
            bar?.alpha = (bar?.alpha == 0 ? 1 : 0)
        }
    }
}
