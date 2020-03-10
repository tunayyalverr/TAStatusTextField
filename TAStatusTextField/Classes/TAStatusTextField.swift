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
    
//    @IBInspectable var normalColor: UIColor?
//    @IBInspectable var editingColor: UIColor?
//    @IBInspectable var successColor: UIColor?
//    @IBInspectable var errorColor: UIColor?
    
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
    public func setupFieldTexts(titleText: String?, errorText: String?, placeholderText: String?) {
        self.titleText = titleText
        self.errorText = errorText
        self.placeholder = placeholderText
        
//        self.addTitleLabel()
//        self.addErrorLabel()
    }
    
    public func setupFieldColors(fieldNormalTitleColor: UIColor?, fieldNormalBackgroundColor: UIColor?, normalBottomLineColor: UIColor?,
                     fieldEditingTitleColor: UIColor?, fieldEditingBackgroundColor: UIColor?, fieldEditingBottomLineColor: UIColor?,
                     fieldSuccessTitleColor: UIColor?, fieldSuccessBackgroundColor: UIColor?, fieldSuccessBottonLineColor: UIColor?,
                     fieldErrorTitleColor: UIColor?, fieldErrorBackgroundColor: UIColor?, fieldErrorBottomLineColor: UIColor?) {
       
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
        
//        self.addBottomLine()
        self.updateText(withColor: fieldTextColor)
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
            self.backgroundColor = normalBackgroundColor
            self.updateTitleLabel(withColor: normalTitleColor)
            self.updateBottomLine(withColor: normalBottomLineColor)
            self.updateRightImage(image: normalImage)
            self.updateErrorLabel(isHidden: true)
        case .editing:
            self.backgroundColor = editingBackgroundColor
            self.updateTitleLabel(withColor: editingTitleColor)
            self.updateBottomLine(withColor: editingBottomLineColor)
            self.updateRightImage(image: editingImage)
            self.updateErrorLabel(isHidden: true)
        case .success:
            self.backgroundColor = successBackgroundColor
            self.updateTitleLabel(withColor: successTitleColor)
            self.updateRightImage(image: successImage)
            self.updateBottomLine(withColor: successBottomLineColor)
            self.updateErrorLabel(isHidden: true)
        case .error:
            self.backgroundColor = errorBackgroundColor
            self.updateTitleLabel(withColor: errorTitleColor)
            self.updateBottomLine(withColor: errorBottomLineColor)
            self.updateRightImage(image: errorImage)
            self.updateErrorLabel(isHidden: false)
        }
    }
    
    //MARK: - Title
    func addTitleLabel() {
        titleLabel = UILabel(frame: CGRect(x: defaultPadding, y: titleTopPadding, width: self.frame.width, height: 20))
        titleLabel.textColor = normalTitleColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = true
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.text = titleText
        self.addSubview(titleLabel)
    }
    
    func updateTitleLabel(withColor: UIColor) {
//        guard titleLabel != nil else { return }
        titleLabel.textColor = withColor
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
            imageView.image = image
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
        errorLabel?.isHidden = isHidden
    }
    
    func addBottomLine() {
        bottomLine = UIView(frame: CGRect(x: 20, y: self.frame.height - bottomLineBottomPadding, width: self.frame.width - 2*defaultPadding, height: bottomLineHeight))
        bottomLine?.backgroundColor = normalBackgroundColor
        self.addSubview(bottomLine!)
    }
    
    func updateBottomLine(withColor: UIColor) {
        bottomLine?.backgroundColor = withColor
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
