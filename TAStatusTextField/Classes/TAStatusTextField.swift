//
//  TAStatusTextField.swift
//  Pods-TAStatusTextField_Tests
//
//  Created by tunay alver on 5.03.2020.
//

import UIKit

@IBDesignable
public class TAStatusTextField: UITextField {
        
    //MARK: - Outlets
    private var titleLabel: UILabel!
    private var bottomLine: UIView!
    private var errorLabel: UILabel!
    private var rightImageView: UIImageView!
    
    //MARK: - Image Names
    @IBInspectable var normalImage: UIImage?
    @IBInspectable var editingImage: UIImage?
    @IBInspectable var successImage: UIImage?
    @IBInspectable var errorImage: UIImage?
    
    //MARK: - Numbers
    var defaultPadding = CGFloat(20)
    var titleTopPadding = CGFloat(20)
    var bottomLineHeight = CGFloat(1)
    var bottomLineBottomPadding = CGFloat(20)
    var rightImageViewRightPadding = CGFloat(20)
    
    //MARK: - Properties
    @IBInspectable var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    @IBInspectable var errorText: String? {
        didSet {
            errorLabel.text = errorText
        }
    }
    
    var shouldSecureText: Bool?
    
    //MARK: State
    public enum Status {
        case normal
        case editing
        case success
        case error
    }
    
    public var status: Status = .normal {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Colors
    @IBInspectable var fieldTextColor: UIColor! = .black
    
    @IBInspectable var errorLabelColor: UIColor! = .black
    
    //MARK: - Colors Normal
    @IBInspectable var normalTitleColor: UIColor! = .clear
    @IBInspectable var normalBackgroundColor: UIColor! = .clear
    @IBInspectable var normalBottomLineColor: UIColor! = .clear
    
    //MARK: - Colors Editing
    @IBInspectable var editingTitleColor: UIColor! = .clear
    @IBInspectable var editingBackgroundColor: UIColor! = .clear
    @IBInspectable var editingBottomLineColor: UIColor! = .clear
    
    //MARK: - Colors Success
    @IBInspectable var successTitleColor: UIColor! = .clear
    @IBInspectable var successBackgroundColor: UIColor! = .clear
    @IBInspectable var successBottomLineColor: UIColor! = .clear
    
    //MARK: - Colors Error
    @IBInspectable var errorTitleColor: UIColor! = .clear
    @IBInspectable var errorBackgroundColor: UIColor! = .clear
    @IBInspectable var errorBottomLineColor: UIColor! = .clear
    
    //MARK: - Animation
    public var animationDuration: Double! = 0.3
    public var colorChangeAnimationOption: UIView.AnimationOptions! = .transitionCrossDissolve
    public var animationOption: UIView.AnimationOptions! = .curveEaseInOut
    
    enum AnimationDirection {
        case top
        case bottom
    }
    
    //MARK: - Init Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    func commonInit() {
        self.addTitleLabel()
        self.addErrorLabel()
        self.addBottomLine()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateSubviewsFrame()
    }
    
    //MARK: - Setup
    public func setupFieldTexts(titleText: String?, errorText: String?) {
        self.titleText = titleText
        self.errorText = errorText
    }
    
    public func setupFieldColors(fieldTextColor: UIColor?,
                     fieldNormalTitleColor: UIColor?, fieldNormalBackgroundColor: UIColor?, normalBottomLineColor: UIColor?,
                     fieldEditingTitleColor: UIColor?, fieldEditingBackgroundColor: UIColor?, fieldEditingBottomLineColor: UIColor?,
                     fieldSuccessTitleColor: UIColor?, fieldSuccessBackgroundColor: UIColor?, fieldSuccessBottonLineColor: UIColor?,
                     fieldErrorTitleColor: UIColor?, fieldErrorBackgroundColor: UIColor?, fieldErrorBottomLineColor: UIColor?) {
       
        self.fieldTextColor = fieldTextColor
        
        self.normalTitleColor = fieldNormalTitleColor
        self.normalBackgroundColor = fieldNormalBackgroundColor
        self.normalBottomLineColor = normalBottomLineColor
        
        self.editingTitleColor = fieldEditingTitleColor
        self.editingTitleColor = fieldEditingTitleColor
        self.editingBottomLineColor = fieldEditingBottomLineColor
        
        self.successTitleColor = fieldSuccessTitleColor
        self.successBackgroundColor = fieldSuccessBackgroundColor
        self.successBottomLineColor = fieldSuccessBottonLineColor
        
        self.errorTitleColor = fieldErrorTitleColor
        self.errorBackgroundColor = fieldErrorBackgroundColor
        self.errorBottomLineColor = fieldErrorBottomLineColor
        
        self.updateText(withColor: fieldTextColor ?? .black)
    }
    
    public func setupRightImages(normalImage: UIImage?, editingImage: UIImage?, successImage: UIImage?, errorImage: UIImage?) {
        self.normalImage = normalImage
        self.editingImage = editingImage
        self.successImage = successImage
        self.errorImage = errorImage
    }
    
    //MARK: - Update Functions
    public func updateViews() {
        self.isSecureTextEntry = shouldSecureText ?? false
        switch status {
        case .normal:
            self.updateBackground(withColor: normalBackgroundColor)
            self.updateTitleLabel(withColor: normalTitleColor, animated: true)
            self.animateTitleLabel(animationDirection: .bottom)
            self.updateBottomLine(withColor: normalBottomLineColor)
            self.updateRightImage(image: normalImage)
            self.updateErrorLabel(isHidden: true)
        case .editing:
            self.updateBackground(withColor: editingBackgroundColor)
            self.updateTitleLabel(withColor: editingTitleColor, animated: true)
            self.animateTitleLabel(animationDirection: .top)
            self.updateBottomLine(withColor: editingBottomLineColor)
            self.updateRightImage(image: editingImage)
            self.updateErrorLabel(isHidden: true)
        case .success:
            self.updateBackground(withColor: successBackgroundColor)
            self.updateTitleLabel(withColor: successTitleColor, animated: true)
            self.updateRightImage(image: successImage)
            self.updateBottomLine(withColor: successBottomLineColor)
            self.updateErrorLabel(isHidden: true)
        case .error:
            self.updateBackground(withColor: errorBackgroundColor)
            self.updateTitleLabel(withColor: errorTitleColor, animated: true)
            self.updateBottomLine(withColor: errorBottomLineColor)
            self.updateRightImage(image: errorImage)
            self.updateErrorLabel(isHidden: false)
        }
    }
    
    //MARK: - Background
    func updateBackground(withColor: UIColor) {
        UIView.animate(withDuration: animationDuration, delay: 0, options: animationOption, animations: {
            self.backgroundColor = withColor
        }, completion: nil)
    }
    
    //MARK: - Title
    func addTitleLabel() {
        titleLabel = UILabel(frame: CGRect(x: defaultPadding, y: self.frame.height / 2, width: self.frame.width, height: 20))
        titleLabel.textColor = normalTitleColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = true
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.text = titleText
        self.addSubview(titleLabel)
    }
    
    func updateTitleLabel(withColor: UIColor, animated: Bool) {
        if animated {
            UIView.transition(with: titleLabel, duration: animationDuration, options: colorChangeAnimationOption, animations: {
                self.titleLabel.textColor = withColor
            }, completion: nil)
        }else {
            titleLabel.textColor = withColor
        }
    }
    
    func animateTitleLabel(animationDirection: AnimationDirection) {
        switch animationDirection {
        case .top:
            UIView.animate(withDuration: animationDuration, delay: 0, options: animationOption, animations: {
                self.titleLabel.frame = CGRect(x: self.defaultPadding, y: self.titleTopPadding, width: self.frame.width, height: 20)
            }, completion: nil)
        case .bottom:
            UIView.animate(withDuration: animationDuration, delay: 0, options: animationOption, animations: {
                self.titleLabel.frame = CGRect(x: self.defaultPadding, y: self.frame.height / 2, width: self.frame.width, height: 20)
            }, completion: nil)
        }
    }
    
    func updateText(withColor: UIColor) {
        self.contentVerticalAlignment = .center
        self.tintColor = withColor
        self.textColor = withColor
    }
    
    //MARK: Right Image
    func updateRightImage(image: UIImage?) {
        if image != nil {
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
            
            imageView.contentMode = .scaleAspectFit
            
            imageView.popOutView(duration: animationDuration)
            UIView.animate(withDuration: animationDuration, delay: animationDuration, options: colorChangeAnimationOption, animations: {
                imageView.image = image
            }, completion: nil)
            rightView = imageView
        }else {
            self.rightViewMode = .never
            rightImageView = nil
        }
    }
    
    //MARK: - Error Label
    func addErrorLabel() {
        errorLabel = UILabel(frame: CGRect(x: defaultPadding, y: self.frame.height - 20, width: self.frame.width, height: 20))
        errorLabel?.textColor = errorLabelColor
        errorLabel?.translatesAutoresizingMaskIntoConstraints = true
        errorLabel?.textAlignment = .left
        errorLabel?.numberOfLines = 1
        errorLabel?.isHidden = true
        errorLabel.text = errorText
        self.addSubview(errorLabel!)
    }
    
    func updateErrorLabel(isHidden: Bool) {
        UIView.animate(withDuration: animationDuration, delay: 0, options: colorChangeAnimationOption, animations: {
            self.errorLabel?.isHidden = isHidden
            if isHidden {
                self.errorLabel.alpha = 0
            }else {
                self.errorLabel.alpha = 1.0
            }
        }, completion: nil)
    }
    
    func addBottomLine() {
        bottomLine = UIView(frame: CGRect(x: 20, y: self.frame.height - bottomLineBottomPadding, width: self.frame.width - 2*defaultPadding, height: bottomLineHeight))
        bottomLine?.backgroundColor = normalBackgroundColor
        self.addSubview(bottomLine!)
    }
    
    func updateBottomLine(withColor: UIColor) {
        UIView.animate(withDuration: animationDuration, delay: 0, options: colorChangeAnimationOption, animations: {
            self.bottomLine?.backgroundColor = withColor
        }, completion: nil)
    }
    
    func updateSubviewsFrame() {
        bottomLine?.frame = CGRect(x: 20, y: self.frame.height - bottomLineBottomPadding, width: self.frame.width - 2*defaultPadding, height: bottomLineHeight)
    }
    
    //MARK: - Text Rect
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: defaultPadding, left: defaultPadding, bottom: 0, right: defaultPadding + 16))
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: defaultPadding, left: defaultPadding, bottom: 0, right: defaultPadding + 16))
    }
    
    //MARK: - Right View Rect
    override public func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        //NOTE: - 16 is image default height
        return CGRect(x: self.frame.width - defaultPadding - 16, y: self.frame.height - defaultPadding - 26, width: 16, height: 16)
    }
    
}

//MARK: - UIView Extension
extension UIView {
    //MARK: - Fade
    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    
    //MARK: - Pop
    func popOutView(duration: Double){
        self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [],  animations: {
            self.transform = .identity
        })
    }
    
    func popInView(duration: Double){
        self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [],  animations: {
            self.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        })
    }
}
