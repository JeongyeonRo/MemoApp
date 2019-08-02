
import UIKit

class MemoReadViewController: UIViewController {

    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    //상위 뷰 컨트롤러로부터 데이터를 넘겨받가 위한 변수 설정
    var memoVO: MemoVO?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       subject.text = memoVO?.title
        contents.text = memoVO?.content
        img.image = memoVO?.image
        
        let formmatter = DateFormatter()
        formmatter.dateFormat = "dd일 HH:mm에 작성"
        let dateString = formmatter.string(from: (memoVO?.regdate)!)
        self.navigationItem.title = dateString
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
