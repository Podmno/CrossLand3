//
//  TVForumTable.swift
//  CrossLand
//
//  Created by Ki MNO on 2024/4/22.
//

import UIKit

struct TVForumTableConfiguration {
    
}

struct TVMainContentCellConfiguration {
    var contentSelectable: Bool = false
    
    var mainThread: LSThread = LSThread()
}

class TVCForumTable: UITableViewController {
    
    let API = LCAPI()
    var mainThreadDisplayList: [LSThread] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let queue = DispatchQueue(label: "initTableContent")
        queue.async {
            let result = self.API.getForum(forumID: 4, forumPage: 1)
            
            DispatchQueue.main.async {
                self.mainThreadDisplayList.append(contentsOf: result)
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVMainContentCell.identifier, for: indexPath) as! TVMainContentCell
        var cfg = TVMainContentCellConfiguration()
        cfg.mainThread = mainThreadDisplayList[indexPath.row]
        cell.configurationTable = cfg
        cell.setupContent()
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mainThreadDisplayList.count
    }



}


class TVButtonCellGroup: UITableViewCell {
    

    
    static let identifier = "groupButton"
    @IBOutlet weak var btnDoPost: ZFRippleButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if #available(macCatalyst 15.0,iOS 15.0, *) {
            //btnDoPost.titleLabel?.textColor = UIColor.tintColor
        } else {
            // Fallback on earlier versions
        }
    }
    var statusNotice = false
    @IBAction func btnNotice(_ sender: TRRippleButton) {
        statusNotice = !statusNotice
        sender.active(statusNotice)
    }
    
    var statusPost = false
    @IBAction func btnPost(_ sender: TRRippleButton) {
        statusPost = !statusPost
        sender.active(statusPost)
    }
    
}

let demo = """


&bull; 使用逻辑与旧岛相同，禁晒妹及恶臭现充话题，建议点击<strong><a href="/t/50000001">→ 全岛总版规 ←</a><font color="#789922">&gt;&gt;No.50000001</font></strong>及各分版版规<br />
&bull; 如对某版规存在异议，请点击<a href="/t/50286677" target="_blank">→ 既往公告及补充说明 ←</a><font color="#789922">&gt;&gt;No.50286677</font> 如仍有异议请转至圈内
<br />
&bull; 客户端下载地址：<a href="https://app.nmbxd.com" target="_blank">https://app.nmbxd.com</a><br />


"""


class TVMainContentCell: TRRippleCell, UITextViewDelegate {
    
    var configurationTable = TVMainContentCellConfiguration()
    
    static let identifier = "mainCell"
    
    @IBOutlet weak var tvMain: TVMainContentCellTextView!
    
    @IBOutlet weak var titleTop: UILabel!
    
    @IBOutlet weak var titleNo: UILabel!
    @IBOutlet weak var titleDate: UILabel!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var stackTop: UIStackView!
    @IBOutlet weak var stackBottom: UIStackView!
    
    
    @IBOutlet weak var csViewImageHeight: NSLayoutConstraint!
    @IBOutlet weak var csViewImageWidth: NSLayoutConstraint!
    
    
    @IBOutlet weak var csStackBottomHeight: NSLayoutConstraint!
    @IBOutlet weak var csStackTopHeight: NSLayoutConstraint!
    
    let imagePreviewView = TRImageLite()
    
    public func setupContent() {
        print("setup Thread with \(configurationTable.mainThread.threadID)")
        
        titleTop.text = configurationTable.mainThread.threadUserHash
        tvMain.attributedText = parser.parseAttributedLabel(content: configurationTable.mainThread.threadContent)
        titleNo.text = "No.\(configurationTable.mainThread.threadID)"
        let date = LCParser.shared.parseThreadTime(dateString: configurationTable.mainThread.threadDate)
        titleDate.text = LCParser.shared.getTimeCurrentDescription(timeStamp: date.timeIntervalSince1970)
        
        if configurationTable.mainThread.threadImg.isEmpty {
            //csViewImageWidth.constant = 10.0
            csViewImageHeight.constant = 1.0
            viewImage.isHidden = true
            imagePreviewView.awakeFromNib()
            //imagePreviewView.removeFromSuperview()
        } else {
            //csViewImageWidth.constant = 200.0
            csViewImageHeight.constant = 200.0
            viewImage.isHidden = false
            imagePreviewView.imageUrl = "https://image.nmb.best/image/\(configurationTable.mainThread.threadImg)\(configurationTable.mainThread.threadExt)"
            
            imagePreviewView.awakeFromNib()
        }
        imagePreviewView.frame = viewImage.bounds
    }
    
    let parser = LCForumHTML()
    public override func awakeFromNib() {
        super.awakeFromNib()

        
        viewImage.addSubview(imagePreviewView)
        imagePreviewView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        tvMain.delegate = self

        setupContent()

        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    

    

//
//    func textViewDidChangeSelection(_ textView: UITextView) {
//        textView.selectedTextRange = nil
//    }
}

class TVMainContentCellTextView: UITextView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {

        guard let pos = closestPosition(to: point) else { return false }

        guard let range = tokenizer.rangeEnclosingPosition(pos, with: .character, inDirection: .layout(.left)) else { return false }

        let startIndex = offset(from: beginningOfDocument, to: range.start)
        if (event?.type == .touches) {
            let click_href = attributedText.attribute(.link, at: startIndex, effectiveRange: nil)
            if (click_href != nil && touchDelayed == false) {
                touchDelayed = true
                Timer.scheduledTimer(timeInterval: 1.3, target: self, selector: #selector(delayLinkTouch), userInfo: nil, repeats: false)
                //print(click_href)
                NotificationCenter.default.post(name: Notification.Name("userClickedHref"), object: click_href!)
            }
        }
        
        return attributedText.attribute(.link, at: startIndex, effectiveRange: nil) != nil
    }
    
    var touchDelayed = false
    @objc func delayLinkTouch() {
        touchDelayed = false
    }
    
    
}



//        if !(tvMain.gestureRecognizers == nil) {
//            for recognizer in tvMain.gestureRecognizers! {
//                if recognizer.isMember(of: UITapGestureRecognizer.self) {
//                    tvMain.removeGestureRecognizer(recognizer)
//                }
//            }
//        }
