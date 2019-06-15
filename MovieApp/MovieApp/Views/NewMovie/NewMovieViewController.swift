//
//  NewMovieViewController.swift
//  MovieApp
//
//  Created by Ayman Fathy on 6/15/19.
//  Copyright © 2019 Instabug Inc. All rights reserved.
//

import UIKit
import NotificationCenter
class NewMovieViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var overViewTextView: UITextView!
    @IBOutlet weak var releaseDataPicker: UIDatePicker!
    
    @IBAction func saveNewMovieAction(_ sender: Any) {
        if checkforDataFeilds() {
          let moiveData = getMovieDataInputs()
        }else{
            //TODO : - show alert to fill inputs
        }
    }
    // MARK: - Variables
    var presenter: NewMoviePresenter!
    private var isImageChanged:Bool = false
    
    // MARK : - Initializer
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        presenter = NewMoviePresenter.init(viewController: self) // inject viewController
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        presenter = NewMoviePresenter.init(viewController: self) // inject viewController
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutSubviews()
        setupImageTapGesture()
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        //setting toolbar as inputAccessoryView
        self.titleLabel.inputAccessoryView = toolbar
        self.overViewTextView.inputAccessoryView = toolbar
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
  @objc func doneButtonAction() {
        self.view.endEditing(true)
    
    }
   @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print("notification: Keyboard will show")
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
   @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height - 102
            }
        }
    }
    func setupKeyboardView()
    {
        
    }
    
    // MARK: - Functions
    private func setupImageTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.showImagePickerAlert))
        posterImageView.isUserInteractionEnabled = true
        posterImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    private func getMovieDataInputs()-> Result2{
        let title = titleLabel.text!
        let releaseDate = presenter.getStringDate(date: releaseDataPicker.date)
        let overView = overViewTextView.text
        let imageDate = posterImageView.image!.pngData()
        let newMoviewObj = Result2.init(title: title, releaseDate: releaseDate, overview: overView! , imageData: imageDate!)
        return newMoviewObj
    }
    private func checkforDataFeilds()-> Bool{
        if titleLabel.text == "" || overViewTextView.text == "" || !isImageChanged{
            return false
        }
        return true
    }
}

extension NewMovieViewController: NewMovieViewControllerProtocol,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    @objc func showImagePickerAlert(){
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            posterImageView.contentMode = .scaleToFill
            posterImageView.image = pickedImage
            isImageChanged = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
