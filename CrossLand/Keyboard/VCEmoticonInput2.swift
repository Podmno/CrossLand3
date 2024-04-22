//
//  VCEmoticonInput2.swift
//  CrossLand
//
//  Created by Ki MNO on 2024/4/22.
//

import UIKit

class VCEmoticonInput2: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emoticonContentArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == emoticonContentArray.count) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCellButtonID, for: indexPath) as! EmoticonInputButtonCell
            cell.button.titleLabel?.text = "Hello"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCellTextID, for: indexPath) as! EmoticonInputTextCell
            cell.lbContent.text = emoticonContentArray[indexPath.row]
            return cell
        }
        
    }
    
    
    let reusableCellTextID = "emoticon"
    let reusableCellButtonID = "buttonAdd"
    
    var emoticonContentArray: [String] = []

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        emoticonContentArray.append(contentsOf: emoticonSet1)
        emoticonContentArray.append(contentsOf: emoticonSet2)
        emoticonContentArray.append(contentsOf: emoticonSet3)
        emoticonContentArray.append(contentsOf: emoticonSet4)
        emoticonContentArray.append(contentsOf: emoticonSet5)
        emoticonContentArray.append(contentsOf: emoticonSet6)
        emoticonContentArray.append(contentsOf: emoticonSet7)
        emoticonContentArray.append(contentsOf: emoticonSet8)
        emoticonContentArray.append(contentsOf: emoticonSet9)
        emoticonContentArray.append(contentsOf: emoticonSet10)
        emoticonContentArray.append(contentsOf: emoticonSet11)
        emoticonContentArray.append(contentsOf: emoticonSet12)
        emoticonContentArray.append(contentsOf: emoticonSet13)
        emoticonContentArray.append(contentsOf: emoticonSet14)
        emoticonContentArray.append(contentsOf: emoticonSet15)
    }


}

class EmoticonInputTextCell: UICollectionViewCell {
    
    @IBOutlet weak var lbContent: UILabel!
}

class EmoticonInputButtonCell: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!
}


let emoticonSet1 = [

    "(・∀・)",
    "(ﾟ∀ﾟ)",
    "(*ﾟ∀ﾟ*)",
    "(´∀`)",
    "(*´∀`)",
    "(〃∀〃)",
    "(//∇//)",
    "(ゝ∀･)",
    "ﾟ ∀ﾟ)ノ",
    "(ノﾟ∀ﾟ)ノ",
    "( へ ﾟ∀ﾟ)べ",
    "(*ﾟ∇ﾟ)",
    "(＾o＾)ﾉ",
    "ᕕ( ᐛ )ᕗ",
    "ε=ε=(ノ≧∇≦)ノ",
    "(`ヮ´)",
    "(`ゥ´ )",
    "↙(`ヮ´ )↗",
    "･ﾟ( ﾉヮ´ )",
    "(;´ヮ`)7",
    "=͟͟͞͞( 'ヮ' 三 'ヮ' =͟͟͞͞)",



]

let emoticonSet2 = [

    "σ`∀´)",
    "ﾟ∀ﾟ)σ",
    "(σﾟ∀ﾟ)σ",
    "(ﾟ∀。)",
    "( ﾟ∀。)7\"",
    "ᕕ( ﾟ∀。)ᕗ",
    "(`ヮ´ )σ`´Д`)∀´) ﾟ∀ﾟ)σ",

]

let emoticonSet3 = [

    "(·ω·)",
    "(・ω・)",
    "(｀･ω･)",
    "(｀・ω)",
    "(´・ω)",
    "(`・ω・´)",
    "(´・ω・`)",
    "(=・ω・=)",
    "(/ω＼)",
    "(^・ω・^)",
    "(*´ω`*)",
    "(ﾟωﾟ)",
    "( ﾟωﾟ)",
    "(oﾟωﾟo)",
    "(=ﾟωﾟ)=",
    "⊂( ﾟωﾟ)つ",
    "ฅ(^ω^ฅ)",
    "(´；ω；`)",
    "ヾ(´ωﾟ｀)",
    "（<ゝω・）☆",
    "(　↺ω↺)",
    "(ﾉ)`ω´(ヾ)",
    "( ›´ω`‹ )",
    "乁( ˙ ω˙乁)",
    "( *・ω・)✄╰ひ╯"

]

let emoticonSet4 = [
    "(^ω^)",
    "( ^ω^)",
    "(　^ω^)",
    "(　ˇωˇ)",
    "(ベ ˇωˇ)べ",
    "⁽ ^ᐜ^⁾",
    "⁽ ˆ꒳ˆ⁾",
    "⁽ ˇᐜˇ⁾",
    "(｡◕∀◕｡)",
    "(　ˇωˇ )◕∀◕｡)^ω^)"
]

let emoticonSet5 = [
    "(ﾟдﾟ)",
    "(;ﾟдﾟ)",
    "Σ( ﾟдﾟ)",
    "Σ(ﾟдﾟ;)",
    "(´ﾟДﾟ`)",
    "(´ﾟДﾟ`)？？？",
    "(σﾟдﾟ)σ",
    "(つд⊂)",
    "ﾟÅﾟ )",
    "(|||ﾟдﾟ)",
    "(　д )",
    "(((ﾟдﾟ)))",
    "(((　ﾟдﾟ)))",
    "(ﾟДﾟ≡ﾟДﾟ)",
    "(ﾟДﾟ≡ﾟдﾟ)!?",
    "Σ(っ °Д °;)っ",
    "(☉д⊙)"

]

let emoticonSet6 = [
    "(`д´)",
    "ヽ(`Д´)ﾉ",
    "m9( `д´)",
    "( `д´)9",
    "( `д´)σ",
    "(σﾟдﾟ)σ",
    "(#ﾟдﾟ)",
    "(╬ﾟдﾟ)",
    "( ｣ﾟДﾟ)｣＜",
    "(`・´)",
    "( ` ・´)",
    "( ᑭ`д´)ᓀ))д`)",
    "( ᑭ`д´)ᓀ))д´)ᑫ",
    "ᑭ`д´)ᓀ ∑ᑭ(`ヮ´ )ᑫ",
    "`ー´) `д´) `д´)"
]


let emoticonSet7 = [
    "(>д<)",
    "(´д`)",
    "( ´д`)",
    "(*´д`)",
    "(;´Д`)",
    "(/TДT)/",
    "(TдT)",
    "( TдT)",
    "(-д-)",
    "ﾟ(つд`ﾟ)",
    "･ﾟ( ﾉд`ﾟ)",
    "( ;`д´; )"
    
    
]

let emoticonSet8 = [
    "( ·_ゝ·)",
    "(・_ゝ・)",
    "(´_ゝ`)",
    "( ´_ゝ`)旦",
    "(´_っ`)",
    "( `_っ´)",
    "((;¬_¬)",
    "(´･_･`)",
    "(´ー`)",
    "(`ー´)",
    "(*ﾟーﾟ)",
    "(・ー・)",
    "←_←",
    "→_→",
    "(<_<)",
    "(>_>)",
    "( ・_ゝ・) ﾉд`ﾟ)´д`)´ﾟДﾟ`)",
    "摸摸( ´･･)ﾉ(._.`)"

]


let emoticonSet9 = [
    "|∀ﾟ)",
    "|∀`)",
    "|д`)",
    "|дﾟ)",
    "| ω・´)",
    "|ー`)",
    "|-`)"

]

let emoticonSet10 = [
    "(|||^ヮ^)",
    "(|||ˇヮˇ)"

]

let emoticonSet11 = [
    "⊂彡☆))д´)",
    "⊂彡☆))д`)",
    "⊂彡☆))∀`)",
    "(´∀((☆ミつ"
]

let emoticonSet12 = [
    "(ﾟ3ﾟ)",
    "(`ε´)",
    "(`ε´ )",
    "ヾ(´ε`ヾ)",
    "(`ε´ (つ*⊂)"
]


let emoticonSet13 = [
    "(￣∇￣)",
    "╮(￣▽￣)╭",
    "(￣3￣)",
    "(￣ε(#￣)",
    "(￣ｰ￣)",
    "(￣ . ￣)",
    "(￣皿￣)",
    "(￣艸￣)",
    "(￣︿￣)",
    "（￣へ￣）",
    "(￣︶￣)",
    "(〜￣△￣)〜",
    "Σ( ￣□￣||)",
    "(\"▔□▔)/",
    "(●￣(ｴ)￣●)"

]

let emoticonSet14 = [
    "( ´ρ`)",
    "σ( ᑒ )",
    "( ﾟπ。)",
    "ᐕ)⁾⁾",
    "(っ˘Д˘)ノ♪",
    "U•ェ•*U",
    "/( ◕‿‿◕ )\\",
    "¯\\_(ツ)_/¯",
    "┃電柱┃",
    "接☆龙☆大☆成☆功",
    "(笑)",
    "(汗)",
    "(泣)",
    "(苦笑)",
    "☎110"

]

let emoticonSet15 = [
"""
吁~~~~　　rnm，退钱！
　　　/　　　/
(　ﾟ 3ﾟ) `ー´) `д´) `д´)
""",
"""
　σ　σ
σ(　´ρ`)σ[F5]
　σ　σ
""",
"""
╭◜◝ ͡ ◜◝ JJ
(　　　　 `д´) 　“咩！”
╰◟д◞ ͜ ◟д◞
""",
"""
( `д´) 预备备！笑！
哈！哈！哈！哈！哈！哈！哈！哈！哈！
( `д´) `д´) `д´) `д´) `д´) `д´) `д´) `д´) `д´)好~~~~　　　再来一个！
""",
"""
　/)　/)
c(　╹^╹)
""",
"""
（\\_/）
(・_・)
/ 　>
""",
"""
　／l、
（°､ 。 ７
　l、 ~ヽ
　じしf_, )ノ
""",
"""
　／l、
（ﾟ∀ 。 ７
　l、 ~ヽ
　じしf_, )ノ
""",
"""
　　　　　／＞　　フ
　　　　　| 　_　 _ l
　 　　　／` ミ＿xノ
　　 　 /　　　 　 |
　　　 /　 ヽ　　 ﾉ
　 　 │　　|　|　|
　／￣|　　 |　|　|
　| (￣ヽ＿_ヽ_)__)
　＼二つ
""",
"""
　　　　　／＞　　フ
　　　　　| 　_　 _ l
　 　　　／` ミ＿xノ
　　 　 /　　　 　 |
　　　 /　 ヽ　　 ﾉ　　　　　╱|、
　 　 │　　|　|　|　　　　　(˚ˎ 。7
　／￣|　　 |　|　|　　　　　|、˜〵
　| (￣ヽ＿_ヽ_)__) 　　　　 じしˍ,)ノ
　＼二つ
"""

]
