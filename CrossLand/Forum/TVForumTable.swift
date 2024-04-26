//
//  TVForumTable.swift
//  CrossLand
//
//  Created by Ki MNO on 2024/4/22.
//

import UIKit

let staticCDNAddress = "https://image.nmb.best/image/"

struct TVForumTableConfiguration {
    
}

public struct TVMainContentCellConfiguration {
    public var contentSelectable: Bool = false
    
    // 提前渲染富文本 取消：取得的性能收益不明显并且会导致辅助功能的字体大小调节功能失效
    //public var renderTextView: NSAttributedString? = nil
    
    public var timeDescription: String = ""
    
    public var threadExtraData: String = ""
    

    
    var mainThread: LSThread = LSThread() {
        didSet {
            //renderTextView = LCForumHTML.shared.parseAttributedLabel(content: mainThread.threadContent)
            let date = LCParser.shared.parseThreadTime(dateString: mainThread.threadDate)
            timeDescription = LCParser.shared.getTimeCurrentDescription(timeStamp: date.timeIntervalSince1970)
            
            if (mainThread.threadTitle != "无标题") {
                threadExtraData += "标题：\(mainThread.threadTitle)   "
            }
            
            if (mainThread.threadName != "无名氏") {
                threadExtraData += "用户：\(mainThread.threadName)   "
            }
            

            
        }
    }
}

class TVCForumTable: UITableViewController {
    
    let API = LCAPI()
    //var mainThreadDisplayList: [LSThread] = []
    var mainThreadConfigurationList: [TVMainContentCellConfiguration] = []
    
    var currentPage = 1
    
    let storyboardForum = UIStoryboard(name: "Forum", bundle: Bundle.main)
    var loadingViewController: UIViewController? = nil
    var loadingCell: UITableViewCell? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingViewController = storyboardForum.instantiateViewController(withIdentifier: "bottomLoading")
        loadingCell = UITableViewCell()
        loadingCell?.addSubview(loadingViewController!.view)
        loadingCell?.backgroundColor = UIColor.clear
        loadingViewController!.view.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let queue = DispatchQueue(label: "initTableContent")
        queue.async {
            let result = self.API.getForum(forumID: 4, forumPage: 1)
            var result_cfg: [TVMainContentCellConfiguration] = []
            
            for th in result {
                var cfg = TVMainContentCellConfiguration()
                // mainThread didSet 方法在子线程完成：富文本渲染 / 时间计算 / 其余标签配置
                cfg.mainThread = th
                result_cfg.append(cfg)
            }
            
            DispatchQueue.main.async {
                self.mainThreadConfigurationList.append(contentsOf: result_cfg)
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 1) {
            return loadingCell ?? UITableViewCell()
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: TVMainContentCell.identifier, for: indexPath) as! TVMainContentCell
        cell.configurationTable = mainThreadConfigurationList[indexPath.row]
        cell.setupContent()
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (section == 0) {
            return mainThreadConfigurationList.count
        }
        if (section == 1) {
            return 1
        }
        return 0
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


class TVMainContentCell: TRRippleCell, UITextViewDelegate {
    
    
    
    var configurationTable = TVMainContentCellConfiguration()

    var preRenderAttributedText: NSAttributedString?
    var topViewStackHeight = 1
    var bottomViewStackHeight = 1
    
    static let identifier = "mainCell"
    
    @IBOutlet weak var tvMain: TVMainContentCellTextView!
    
    @IBOutlet weak var titleTop: UILabel!
    
    @IBOutlet weak var titleNo: UILabel!
    @IBOutlet weak var titleDate: UILabel!
    

    @IBOutlet weak var imageLite: TRImageLite!
    
    @IBOutlet weak var stackTop: UIStackView!
    @IBOutlet weak var stackBottom: UIStackView!
    
    
    @IBOutlet weak var csViewImageHeight: NSLayoutConstraint!
    @IBOutlet weak var csViewImageWidth: NSLayoutConstraint!
    
    public let sb = UIStoryboard(name: "Forum", bundle: Bundle.main)
    

    public func setupContent() {
        //print("setup Thread with \(configurationTable.mainThread.threadID)")
        
        titleTop.text = configurationTable.mainThread.threadUserHash
        

        //if (configurationTable.renderTextView != nil) {
        //    tvMain.attributedText = configurationTable.renderTextView
        //} else {
            
        //}
        tvMain.attributedText = LCForumHTML.shared.parseAttributedLabel(content: configurationTable.mainThread.threadContent)
        
        titleNo.text = "No.\(configurationTable.mainThread.threadID)"
        
        titleDate.text = configurationTable.timeDescription

        if configurationTable.mainThread.threadImg.isEmpty {
            csViewImageHeight.constant = 1.0
            imageLite.isHidden = true
            imageLite.awakeFromNib()
        } else {
            csViewImageHeight.constant = 200.0
            imageLite.isHidden = false
            imageLite.imageUrl = "\(staticCDNAddress)\(configurationTable.mainThread.threadImg)\(configurationTable.mainThread.threadExt)"
            
            imageLite.awakeFromNib()
        }
        

        if (!configurationTable.threadExtraData.isEmpty) {
            let test = sb.instantiateViewController(withIdentifier: "stackTitle") as! TVForumTableCellTitleUser
            test.setupContent(configurationTable.threadExtraData)
            test.view.tag = 9012
            stackTop.addArrangedSubview(test.view)
        } else {
            for v in stackTop.subviews {
                if v.tag == 9012 {
                    v.removeFromSuperview()
                }
            }
        }
        
        if (configurationTable.mainThread.threadSage == 1) {
            let vc_sage = sb.instantiateViewController(identifier: "stackSAGE") as? TVForumTableCellSAGEInfo
            if let v_sage = vc_sage?.view {
                v_sage.tag = 9000
                stackTop.addArrangedSubview(v_sage)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        for view_top in stackTop.subviews {
            view_top.removeFromSuperview()
        }

        //csStackTopHeight.constant = 1.0
        
        for view_bottom in stackBottom.subviews {
            view_bottom.removeFromSuperview()
        }
        
        
        //csStackBottomHeight.constant = 1.0
        
    }
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()

        
        //viewImage.addSubview(imagePreviewView)
        //imagePreviewView.snp.makeConstraints { make in
        //    make.top.bottom.left.right.equalToSuperview()
        //}
        
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


public class TVForumTableCellSAGEInfo: UIViewController {
    @IBOutlet weak var lbContent: UILabel!
}

public class TVForumTableCellTitleUser: UIViewController {
    
    
    @IBOutlet weak var lbContent: UILabel!
    
    var setImage: UIImage = UIImage(named: "title") ?? UIImage()
    var titleContent: String = ""
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lbContent.text = titleContent
    }
    
    public func setupContent(_ content: String) {
        titleContent = content
    }
    
}


//        if !(tvMain.gestureRecognizers == nil) {
//            for recognizer in tvMain.gestureRecognizers! {
//                if recognizer.isMember(of: UITapGestureRecognizer.self) {
//                    tvMain.removeGestureRecognizer(recognizer)
//                }
//            }
//        }
