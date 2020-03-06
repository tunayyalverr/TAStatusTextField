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
    private var titleLabel = UILabel()
    private var errorLabel = UILabel()
    private var bottomLine: UIView!
    private var rightImageView: UIImageView!
    
    //MARK: - Image Names
    @IBInspectable var normalImage = UIImage()
    @IBInspectable var editingImage = UIImage()
    @IBInspectable var successImage = UIImage()
    @IBInspectable var errorImage = UIImage()
    
    //MARK: - Numbers
    var defaultPadding = CGFloat(20)
    var titleTopPadding = CGFloat(20)
    var bottomLineHeight = CGFloat(1)
    var bottomLineBottomPadding = CGFloat(20)
    var rightImageViewRightPadding = CGFloat(20)
    
    //MARK: - Properties
    @IBInspectable var title: String! {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable var errorText: String! {
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
    
    public var status: Status? {
        didSet {
            updateViews()
//            didUpdateStatus(status)
        }
    }
    
    //MARK: - Colors
    @IBInspectable var fieldTextColor: UIColor! = .clear {
        didSet {
            self.updateText(withColor: fieldTextColor)
        }
    }
    @IBInspectable var fieldErrorLabelColor: UIColor! = .clear {
        didSet {
            self.updateErrorLabel(isHidden: true)
        }
    }
    
    //MARK: - Colors Normal
    @IBInspectable var fieldNormalTitleColor: UIColor! = .clear {
        didSet {
            self.updateTitleLabel(withColor: fieldNormalTitleColor)
        }
    }
    @IBInspectable var fieldNormalBackgroundColor: UIColor! = .clear {
        didSet {
            self.backgroundColor = fieldNormalBackgroundColor
        }
    }
    @IBInspectable var fieldNormalBottomLineColor: UIColor! = .clear {
        didSet {
            self.updateBottomLine(withColor: fieldNormalBottomLineColor)
        }
    }
    
    //MARK: - Colors Editing
    @IBInspectable var fieldEditingTitleColor: UIColor! = .clear
    @IBInspectable var fieldEditingBackgroundColor: UIColor! = .clear
    @IBInspectable var fieldEditingBottomLineColor: UIColor! = .clear
    
    //MARK: - Colors Success
    @IBInspectable var fieldSuccessTitleColor: UIColor! = .clear
    @IBInspectable var fieldSuccessBackgroundColor: UIColor! = .clear
    @IBInspectable var fieldSuccessBottomLineColor: UIColor! = .clear
    
    //MARK: - Colors Error
    @IBInspectable var fieldErrorTitleColor: UIColor! = .clear
    @IBInspectable var fieldErrorBackgroundColor: UIColor! = .clear
    @IBInspectable var fieldErrorBottomLineColor: UIColor! = .clear
    
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
        self.status = .normal
        
        addViews()
    }
    
    //MARK: - Setup
    public func setupFieldTexts(titleText: String?, errorText: String?, placeholderText: String?) {
        self.title = titleText
        self.errorText = errorText
        self.placeholder = placeholderText
    }
    
    public func setupFieldColors(fieldNormalTitleColor: UIColor?, fieldNormalBackgroundColor: UIColor?, fieldNormalBottomLineColor: UIColor?,
                     fieldEditingTitleColor: UIColor?, fieldEditingBackgroundColor: UIColor?, fieldEditingBottomLineColor: UIColor?,
                     fieldSuccessTitleColor: UIColor?, fieldSuccessBackgroundColor: UIColor?, fieldSuccessBottonLineColor: UIColor?,
                     fieldErrorTitleColor: UIColor?, fieldErrorBackgroundColor: UIColor?, fieldErrorBottomLineColor: UIColor?) {
       
        self.fieldNormalTitleColor = fieldNormalTitleColor
        self.fieldNormalBackgroundColor = fieldNormalBackgroundColor
        self.fieldNormalBottomLineColor = fieldNormalBottomLineColor
        
        self.fieldEditingTitleColor = fieldEditingTitleColor
        self.fieldEditingTitleColor = fieldEditingTitleColor
        self.fieldEditingBottomLineColor = fieldEditingBottomLineColor
        
        self.fieldSuccessTitleColor = fieldSuccessTitleColor
        self.fieldSuccessBackgroundColor = fieldSuccessBackgroundColor
        self.fieldSuccessBottomLineColor = fieldSuccessBottonLineColor
        
        self.fieldErrorTitleColor = fieldErrorTitleColor
        self.fieldErrorBackgroundColor = fieldErrorBackgroundColor
        self.fieldErrorBottomLineColor = fieldErrorBottomLineColor
    }
    
    public func setupRightImages(normalImage: UIImage, editingImage: UIImage, successImage: UIImage, errorImage: UIImage) {
        self.normalImage = normalImage
        self.editingImage = editingImage
        self.successImage = successImage
        self.errorImage = errorImage
    }
    
    override public func draw(_ rect: CGRect) {
        updateSubviewsFrame()
    }
    
    //MARK: - Update Functions
    func addViews() {
        addTitleLabel()
        self.updateText(withColor: fieldTextColor)
        self.addErrorLabel()
        self.addBottomLine()
    }
    
    func updateViews() { //NOTE: - Field type must be nill this var is for viewController background update where textfield at !
        self.isSecureTextEntry = shouldSecureText ?? false
        switch status! {
        case .normal:
            self.backgroundColor = fieldNormalBackgroundColor
            self.updateTitleLabel(withColor: fieldNormalTitleColor)
            self.updateBottomLine(withColor: fieldNormalBottomLineColor)
            self.updateRightImage(image: normalImage)
            self.updateErrorLabel(isHidden: true)
        case .editing:
            self.backgroundColor = fieldEditingBackgroundColor
            self.updateTitleLabel(withColor: fieldEditingTitleColor)
            self.updateBottomLine(withColor: fieldEditingBottomLineColor)
            self.updateRightImage(image: editingImage)
            self.updateErrorLabel(isHidden: true)
        case .success:
            self.backgroundColor = fieldSuccessBackgroundColor
            self.updateTitleLabel(withColor: fieldSuccessTitleColor)
            self.updateRightImage(image: successImage)
            self.updateBottomLine(withColor: fieldSuccessBottomLineColor)
            self.updateErrorLabel(isHidden: true)
        case .error:
            self.backgroundColor = fieldErrorBackgroundColor
            self.updateTitleLabel(withColor: fieldErrorTitleColor)
            self.updateBottomLine(withColor: fieldErrorBottomLineColor)
            self.updateRightImage(image: errorImage)
            
            self.updateErrorLabel(isHidden: false)
        }
    }
    
    //MARK: - Title
    func addTitleLabel() {
        titleLabel = UILabel(frame: CGRect(x: defaultPadding, y: titleTopPadding, width: self.frame.width, height: 20))
        titleLabel.textColor = fieldNormalTitleColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = true
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        self.addSubview(titleLabel)
    }
    
    func updateTitleLabel(withColor: UIColor) {
        guard titleLabel != nil else { return }
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
        errorLabel.textColor = fieldErrorLabelColor
        errorLabel.translatesAutoresizingMaskIntoConstraints = true
        errorLabel.textAlignment = .left
        errorLabel.numberOfLines = 1
        errorLabel.isHidden = true
        self.addSubview(errorLabel)
    }
    
    func updateErrorLabel(isHidden: Bool) {
        guard errorLabel != nil else { return }
        errorLabel.isHidden = isHidden
    }
    
    func addBottomLine() {
        bottomLine = UIView(frame: CGRect(x: 20, y: self.frame.height - bottomLineBottomPadding, width: self.frame.width - 2*defaultPadding, height: bottomLineHeight))
        bottomLine.backgroundColor = fieldNormalBackgroundColor
        self.addSubview(bottomLine)
    }
    
    func updateBottomLine(withColor: UIColor) {
        guard bottomLine != nil else { return }
         bottomLine.backgroundColor = withColor
    }
    
    func updateSubviewsFrame() {
        guard bottomLine != nil else { return }
        bottomLine.frame = CGRect(x: 20, y: self.frame.height - bottomLineBottomPadding, width: self.frame.width - 2*defaultPadding, height: bottomLineHeight)
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
