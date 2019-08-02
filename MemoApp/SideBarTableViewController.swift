
import UIKit

class SideBarTableViewController: UITableViewController {
    
    //헤더 뷰를 위한 인스턴스를 생성
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let profileImage = UIImageView()
    
    let titles = ["새 글 작성하기", "계정관리"]
    let icons = [UIImage(named: "icon01.png"), UIImage(named: "icon02.png")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //헤더뷰로 사용할 뷰를 생성
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        headerView.backgroundColor = UIColor.lightGray
        self.tableView.tableHeaderView = headerView
        
        //이름 레이블 만들기
        nameLabel.frame = CGRect(x: 70, y: 15, width: 200, height: 30)
        nameLabel.text = "Jeongyeon"
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.backgroundColor = UIColor.clear
        headerView.addSubview(nameLabel)
        
        //이름 레이블 만들기
       emailLabel.frame = CGRect(x: 70, y: 35, width: 200, height: 30)
       emailLabel.text = "rgo0517@gmail.com"
       emailLabel.textColor = UIColor.black
       emailLabel.font = UIFont.boldSystemFont(ofSize: 15)
       emailLabel.backgroundColor = UIColor.clear
       headerView.addSubview(emailLabel)
        
        profileImage.image = UIImage(named: "account.jpg")
        profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        //이미지 라운딩 처리 - 반지름을 부여
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        
        //profileImage.layer.borderWidth = 2
        //profileImage.layer.borderColor = UIColor.red.cgColor
        //경계선 제거 - 라운딩이 이미지에만 적용되기 때문에 제거하는것을 권장
        profileImage.layer.borderWidth = 0
        
        //그림자 효과
        profileImage.layer.masksToBounds = true
        headerView.addSubview(self.profileImage)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    //지워도 됨
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //행 개수 설정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return titles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell")
        cell?.textLabel?.text = titles[indexPath.row]
        cell?.imageView?.image = icons[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            //목적지 뷰 컨트롤러를 생성
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "MemoFormViewController") as! MemoFormViewController
            //네비게이션 컨트롤러 가져오기
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            //화면 이동
            target.pushViewController(destination, animated: true)
            //메뉴를 숨김
            self.revealViewController()?.revealToggle(self)
        }
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
