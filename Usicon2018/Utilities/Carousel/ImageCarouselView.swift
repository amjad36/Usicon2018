//
//  CarouselPagerView.swift
//

import UIKit

protocol ImageCarouselViewDelegate {
    func scrolledToPage(_ page: Int)
}

@IBDesignable
class ImageCarouselView: UIView {
    
    var delegate: ImageCarouselViewDelegate?
    
    @IBInspectable var showPageControl: Bool = false {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var pageControlMaxItems: Int = 10 {
        didSet {
            setupView()
        }
    }
    var pageLabel = UILabel()
    
    var carouselScrollView: UIScrollView!
    
    var xOffSet: CGFloat = 0.0
    
    var timer: Timer?
    
    var images = [UIImage]() {
        didSet {
            setupView()
        }
    }
    
    var pageControl = UIPageControl()
    
    var currentPage: Int! {
        return Int(round(carouselScrollView.contentOffset.x / self.bounds.width))
    }
    
    @IBInspectable var pageColor: UIColor? {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var currentPageColor: UIColor? {
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        for view in subviews {
            view.removeFromSuperview()
        }
        
        carouselScrollView = UIScrollView(frame: bounds)
        carouselScrollView.showsHorizontalScrollIndicator = false
        
        addImages()
        addAutoscroll()
        
        if showPageControl {
            addPageControl()
            carouselScrollView.delegate = self
        }
    }
    
    func addImages() {
        carouselScrollView.isPagingEnabled = true
        carouselScrollView.contentSize = CGSize(width: bounds.width * CGFloat(images.count), height: bounds.height)
        
        for i in 0..<images.count {
            let imageView = UIImageView(frame: CGRect(x: bounds.width * CGFloat(i), y: 0, width: bounds.width, height: bounds.height))
            imageView.image = images[i]
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true
            imageView.isUserInteractionEnabled = true
            carouselScrollView.addSubview(imageView)
        }
        
        self.addSubview(carouselScrollView)
    }
    
    func addPageControl() {
        if images.count <= pageControlMaxItems {
            pageControl.numberOfPages = images.count
            pageControl.sizeToFit()
            pageControl.currentPage = 0
            pageControl.center = CGPoint(x: self.center.x, y: bounds.height - pageControl.bounds.height/2 - 8)
            
            if let pageColor = self.pageColor {
                pageControl.pageIndicatorTintColor = pageColor
            }
            if let currentPageColor = self.currentPageColor {
                pageControl.currentPageIndicatorTintColor = currentPageColor
            }
            
            self.addSubview(pageControl)
        } else {
            pageLabel.text = "1 / \(images.count)"
            pageLabel.font = UIFont.systemFont(ofSize: 10.0, weight: UIFont.Weight.light)
            pageLabel.frame.size = CGSize(width: 40, height: 20)
            pageLabel.textAlignment = .center
            pageLabel.layer.cornerRadius = 10
            pageLabel.layer.masksToBounds = true
            
            pageLabel.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.3)
            pageLabel.textColor = UIColor.white
            pageLabel.center = CGPoint(x: self.center.x, y: bounds.height - pageLabel.bounds.height/2 - 8)
            
            self.addSubview(pageLabel)
        }
    }
    
    func addAutoscroll() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateSlide), userInfo: nil, repeats: true)
    }
    
    @objc func updateSlide() {
        
        let carouselOffset = bounds.width * CGFloat(images.count - 1)
        
        if xOffSet == carouselOffset {
            xOffSet = 0
            self.carouselScrollView.contentOffset.x = self.xOffSet
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: {
                    self.carouselScrollView.alpha = 0
                }, completion: nil)
            }
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: {
                    self.carouselScrollView.alpha = 1.0
                }, completion: nil)
            }
            return
        }
        
        xOffSet += bounds.width
        self.carouselScrollView.contentOffset.x = self.xOffSet
        
        DispatchQueue.main.async {
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveLinear, animations: {
                    self.carouselScrollView.alpha = 0
                }, completion: nil)
            }
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: {
                    self.carouselScrollView.alpha = 1.0
                }, completion: nil)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupView()
    }
    
}

extension ImageCarouselView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = self.currentPage
        self.pageLabel.text = "\(self.currentPage+1) / \(images.count)"
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.delegate?.scrolledToPage(self.currentPage)
    }
    
}
