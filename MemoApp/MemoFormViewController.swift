
import UIKit

class MemoFormViewController: UIViewController {
    //제목을 저장할 변수 설정
    var subject : String!

    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    @IBAction func pick(_ sender: Any) {
        //카메라, 저장앨범, 라이브러리 중 하나를 선택하는 대화상자를 출력
        let select = UIAlertController(title: "이미지를 가져올 곳을 선택하세요", message: nil, preferredStyle: .actionSheet)
        //select.addAction(UIAlertAction(title: "카메라", style: .cancel로 설정하면 1개만 배치됨, handler: {(매개변수이름) -> 결과형 코드}))
        select.addAction(UIAlertAction(title: "카메라", style: .default, handler: {(alert) -> Void in self.presentPicker(.camera)}))
        select.addAction(UIAlertAction(title: "앨범", style: .default, handler: {(alert) -> Void in self.presentPicker(.savedPhotosAlbum)}))
        select.addAction(UIAlertAction(title: "라이브러리", style: .default, handler: {(alert) -> Void in self.presentPicker(.photoLibrary)}))
        self.present(select, animated: true)
    }
    @IBAction func save(_ sender: Any) {
        //대화상자 커스터마이징을 위한 ViewController
        let customAlertView = UIViewController()
        customAlertView.view = UIImageView(image:UIImage(named: "warning-icon-60"))
        //인스턴스 ? 내용1 ?? 내용2
        //인스턴스가 nil이 아니면 내용1 nil이면 내용2
        customAlertView.preferredContentSize = UIImage(named: "warning-icon-60")? .size ?? CGSize.zero
        
        //입력한 내용이 없으면 리턴 - 나가버릴 때는 guard
        guard self.contents.text.isEmpty == false
            else{
                let alert = UIAlertController(title: "내용은 필수 입력 사항입니다.", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"확인", style: .cancel))
                alert.setValue(customAlertView, forKey: "contentViewController")
                self.present(alert, animated: true)
                return
        }
        
        //데이터를 저장할 VO 인스턴스를 생성
        let data = MemoVO()
        data.title = subject
        data.content = contents.text
        data.image = preview.image
        data.regdate = Date()
        
        //공유 객체에 데이터 추가
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memoList.insert(data, at:0)
        //이전 뷰 컨트롤러로 돌아가기
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contents.delegate = self
        
        //배경 이미지 설정
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"memo-background.png")!)
        //텍스트뷰에서는 배경 이미지가 출력이 되지 않음
        //텍스트 뷰의 속성을 수정
        self.contents.layer.borderWidth = 0
        //배경색을 투명하게 설정
        self.contents.layer.borderColor = UIColor.clear.cgColor
        self.contents.layer.backgroundColor = UIColor.clear.cgColor
        
        //줄 간격 조정
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 50
        self.contents.attributedText = NSAttributedString(string:" ", attributes: [NSAttributedString.Key.paragraphStyle:style])
        self.contents.text = ""
    }
    

    //이미지 피커를 출력해 줄 사용자 정의 메소드
    func presentPicker(_ source : UIImagePickerController.SourceType){
        //조건에 맞지 않을 때 더 이상 수행하지 않도록 하고자 하면 guard 를 사용
        guard UIImagePickerController.isSourceTypeAvailable(source) == true
            else{
                let alert = UIAlertController(title: "사용할 수 없는 타입입니다.", message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)
                alert.addAction(ok)
                self.present(alert, animated: true)
                return
        }
        //이미지 피커를 만들어서 출력하기
        let picker = UIImagePickerController()
        picker.delegate = self
        //편집 가능 여부 설정
        picker.allowsEditing = true
        picker.sourceType = source
        
        self.present(picker, animated: true)
    }

}

//extension 현재클래스 : - {
extension MemoFormViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //선택된 이미지를 preview에 출력
        self.preview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        //이미지 피커 닫기
        picker.dismiss(animated: true)
    }
}


extension MemoFormViewController : UITextViewDelegate{
    //텍스트 뷰의 내용이 변경될 때 호출되는 메소드
    func textViewDidChange(_ textView: UITextView) {
        //내용을 읽어오기
        //String을 NSString으로 변경해서 사용하는 이유는 NSString에는 문자열 관련 메소드가 많고
        //사용하기도 쉽지만 swift의 String은 메소드 사용법이 까다롭기 때문입니다.
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15:contents.length)
        //문자열 잘라내기
        self.subject = contents.substring(with: NSRange(location:0, length: length))
        //잘라진 문자열을 네비게이션 바에 출력
        self.navigationItem.title = subject
    }
    
    //화면을 터치하고 난 후 호출되는 메소드
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let bar = self.navigationController?.navigationBar
        //1초
        let ts = TimeInterval(1.0)
        UIView.animate(withDuration: ts){
            bar?.alpha = (bar?.alpha == 0 ? 1 : 0)
        }
    }
    
}

