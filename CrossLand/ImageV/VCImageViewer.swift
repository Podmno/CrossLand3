//
//  VCImageViewer.swift
//  CrossLand
//
//  Created by Ki MNO on 2024/4/23.
//

import UIKit
import SnapKit
import Alamofire
import Hero

let demoPictureAddress = "https://www.pokemon.co.jp/special/dungeon_sora/common/img/main.jpg"

class VCImageViewer: UIViewController {

    @IBOutlet weak var panImageView: PanZoomImageView!

    
    //@IBOutlet weak var blurLayer: UIVisualEffectView!
    var placeHolderImage: UIImage? = nil
    
    public func setPlaceHolder(image: UIImage) {
        placeHolderImage = image
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.panImageView.imageView.image = placeHolderImage

        
        NotificationCenter.default.addObserver(self, selector: #selector(receiveViewControllerClose), name: Notification.Name("pictureExit"), object: nil)
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        AF.request(demoPictureAddress).response { re in
            if re.error == nil {
                print("Load Image")
                
                DispatchQueue.main.async {
                    print("setup pic!")
                    let data = re.data
                    let image = UIImage(data: data ?? Data())
                    self.panImageView.imageView.image = image
                    
                }
            } else {
                print("error")
            }
        }
    }
    
    @objc func receiveViewControllerClose(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func closeDemo(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}

class PanZoomImageView: UIScrollView {
    
    public let imageView = UIImageView()
    
    @IBInspectable private var imageName: String? {
        didSet {
            imageView.heroID = "placeHolderImage"

            guard let imageName = imageName else {
                return
            }
            imageView.image = UIImage(named: imageName)
            
        }
    }
    
    convenience init(named: String) {
        self.init(frame: .zero)
        self.imageName = named
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
          addSubview(imageView)
            NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        minimumZoomScale = 1
        maximumZoomScale = 4
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        delegate = self
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTapRecognizer)
        
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown(_:)))
        swipeRecognizer.direction = .down
        addGestureRecognizer(swipeRecognizer)
    }
    
    @objc private func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        if zoomScale == 1 {
            setZoomScale(2, animated: true)
        } else {
            setZoomScale(1, animated: true)
        }
    }
    
    @objc private func handleSwipeDown(_ sender: UISwipeGestureRecognizer) {
        print("swipe!")
        
        NotificationCenter.default.post(name: Notification.Name("pictureExit"), object: nil)
    }
    

}

extension PanZoomImageView: UIScrollViewDelegate {
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
