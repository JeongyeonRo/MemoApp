
import UIKit

class MemoListViewController: UITableViewController {
    
    //AppDelegate 에 대한 참조를 위한 인스턴스 변수 생성
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //우측 + 버튼을 눌렀을 때 호출될 메소드
    @objc func add(_ sender : Any){
        //인터페이스 빌더에서 디자인한 뷰 컨트롤러 인스턴스 만들기
        let memoFormVC = self.storyboard?.instantiateViewController(withIdentifier: "MemoFormViewController") as! MemoFormViewController
        //네비게이션을 이용해서 푸시
        //self.navigationController?.pushViewController(변수명, animated: true)
        self.navigationController?.pushViewController(memoFormVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

       self.title = "메모 목록"
        
        //네비게이션 바의 오른쪽에 + 버튼을 추가해서 메소드 설정
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.add(_:)))
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        //샘플 데이터 생성
        let memo1 = MemoVO()
        memo1.title = "국토대자정"
        memo1.content = "서울에서 목포까지 걸어서, 하루 40km"
        //작성일에는 오늘 날짜 입력
        memo1.regdate = Date()
        appDelegate.memoList.append(memo1)
        
        let memo2 = MemoVO()
        memo2.title = "속초"
        memo2.content = "속초 아바이마을 갯배 타는 곳 아바이 순대집-생선구이 존맛탱"
        memo2.image = #imageLiteral(resourceName: "sokcho.jpeg")
        memo2.regdate = Date(timeIntervalSinceNow: 6000)
        appDelegate.memoList.append(memo2)
    }
    
    //화면에 다시 출력될 때 호출되는 메소드
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //테이블 뷰가 데이터를 다시 출력
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    //그륩의 개수를 설정하는 메소드
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    //행의 개수를 설정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //배열의 데이터 개수만큼 리턴
        return appDelegate.memoList.count
    }

    //셀을 설정하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //행 번호에 해당하는 데이터를 가져오기
        let row = appDelegate.memoList[indexPath.row]
        //이미지가 없으면 cell 아이디는 memoCell, 있으면 memoCellWithImage
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        //셀을 생성
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoTableViewCell
        //내용 출력
        cell.subject.text = row.title
        cell.contents.text = row.content
        
        //cell.regdate.text = row.regdate
        //날짜는 그냥 바로 출력하려고 하면 에러 발생 - Cannot assign value of type 'Date?' to type 'String?'
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate.text = formatter.string(from: row.regdate!)
        
        cell.img?.image = row.image
        return cell
    }

    //셀의 높이를 설정하는 메소드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
        
    }
    
    //셀을 선택했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //하위 뷰 컨트롤러 생성
        let memoReadVC = self.storyboard?.instantiateViewController(withIdentifier: "MemoReadViewController") as! MemoReadViewController
        memoReadVC.memoVO = appDelegate.memoList[indexPath.row]
        self.navigationController?.pushViewController(memoReadVC, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
