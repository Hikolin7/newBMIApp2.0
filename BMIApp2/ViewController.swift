import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Tableで使用する配列を設定する.
    var dataDate: [NSDate] = []
    var dataBmi: [Double] = []
    var dataHight: [Double] = []
    var dataWeight: [Double] = []
    var dataIdealWeight: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // テーブルビューを作る
        let SCREEN = UIScreen.mainScreen().bounds.size
        let myTableView = UITableView(frame: CGRect(x: 0, y: 90, width: SCREEN.width , height: SCREEN.height - 90))
        
        // Viewの高さと幅を取得する.
        //let displayWidth: CGFloat = self.view.frame.width
        //let displayHeight: CGFloat = self.view.frame.height
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
        
        //カスタムセルを指定
        var nib  = UINib(nibName: "CustomTableViewCell", bundle:nil)
        myTableView.registerNib(nib, forCellReuseIdentifier:"Cell")
        
        //テーブルの余白を無くす
        if myTableView.respondsToSelector("setSeparatorInset:") { myTableView.separatorInset = UIEdgeInsetsZero }
        
        readData()
    }
    
    //テーブルの余白を無くす
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset.left = CGFloat(0.0) }
        if tableView.respondsToSelector("setLayoutMargins:") {
            tableView.layoutMargins = UIEdgeInsetsZero }
        if cell.respondsToSelector("setLayoutMargins:") {
            cell.layoutMargins.left = CGFloat(0.0) }
    }

    //CoreDataからのデータ読み込み.*************************
    func readData(){
        // CoreDataの読み込み処理.
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let myContext: NSManagedObjectContext = appDel.managedObjectContext!
        
        let myRequest: NSFetchRequest = NSFetchRequest(entityName: "InfoStore")
        myRequest.returnsObjectsAsFaults = false
        
        var myResults: NSArray! = myContext.executeFetchRequest(myRequest, error: nil)
        
        dataDate = []
        dataBmi = []
        dataHight = []
        dataWeight = []
        dataIdealWeight = []
        
        //var i = 0
        for myData:AnyObject in myResults {
            //let dbTime:NSDate? = myData.valueForKey("date") as? NSDate
            //dataDate.insert(dbTime!,atIndex:i)
            dataDate.append((myData.valueForKey("date") as? NSDate)!)
            dataBmi.append((myData.valueForKey("bmi") as? Double)!)
            dataHight.append((myData.valueForKey("hight") as? Double)!)
            dataWeight.append((myData.valueForKey("weight") as? Double)!)
            dataIdealWeight.append((myData.valueForKey("idealWeight") as? Double)!)
            //i++
        }
        
        dataDate = dataDate.reverse()
        dataBmi = dataBmi.reverse()
        dataHight = dataHight.reverse()
        dataWeight = dataWeight.reverse()
        dataIdealWeight = dataIdealWeight.reverse()
    }
    
    // 行数を返す（UITableViewDataSource）
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 行数はセルデータの個数
        return dataHight.count
    }
    
    // セルにデータを設定する（UITableViewDataSource）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // セルを取り出す
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as CustomTableViewCell
        
       
        // ラベルにテキストを設定する
        
        //日付
        var now = dataDate[indexPath.row]
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.dateStyle = .ShortStyle
        cell.cellDate.text = "\(dateFormatter.stringFromDate(now))"
        
        //BMI値
        cell.cellScoreBMI.text = NSString(format: "%.f", dataBmi[indexPath.row])
        
        //身長
        var shincho = dataHight[indexPath.row] * 100
        cell.cellHight.text = NSString(format: "%.f", shincho) + "cm"
        
        //体重
        cell.cellWeight.text = NSString(format: "%.f", dataWeight[indexPath.row]) + "kg"
        
        //理想体重との差
        var codeIdealWeight = dataIdealWeight[indexPath.row]
        if codeIdealWeight > 0 {
            cell.cellIdealWeight.text = "+" + NSString(format: "%.f", dataIdealWeight[indexPath.row]) + "kg"
            //値が0より大きい場合、先頭に+をつける
        } else {
            cell.cellIdealWeight.text = NSString(format: "%.f", dataIdealWeight[indexPath.row]) + "kg"
        }
        
        // 設定済みのセルを戻す
        return cell
    }
    
    // セクション数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // セルの高さを返す（UITableViewDelegate）
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as CustomTableViewCell
        // セルの高さ
        return cell.bounds.height
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

