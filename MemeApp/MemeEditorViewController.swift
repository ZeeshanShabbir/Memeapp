//
//  MemeEditorViewController.swift
//  MemeApp
//
//  Created by Muhammad Zeeshan Shabbir on 3/7/17.
//  Copyright © 2017 Muhammad Zeeshan Shabbir. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UITextFieldDelegate{

    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var bottomText: UITextField!
    
    @IBOutlet weak var topText: UITextField!
    
    @IBOutlet weak var navbar: UINavigationBar!

    @IBOutlet weak var shareBtn: UIBarButtonItem!
    
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    let textFieldDelegate = TextFieldDelegate()
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0,
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        topText.delegate = textFieldDelegate
        bottomText.delegate = textFieldDelegate
        shareBtn.isEnabled = false
        configureTextField(textfield: topText)
        configureTextField(textfield: bottomText)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func launchCameraa(_ sender: Any) {
        pickImageFromSource(source: .camera)
    }
    
    @IBAction func pickAnImagee(_ sender: Any) {
        pickImageFromSource(source: .photoLibrary)
    }
    
    func configureTextField (textfield: UITextField){
        textfield.defaultTextAttributes = memeTextAttributes
        textfield.textAlignment = .center
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imagePickerView.image = image
            shareBtn.isEnabled = true
        }
        self.dismiss(animated: true, completion: nil)

    }
    
    
    func pickImageFromSource(source : UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func keyboardWillShow(_ notification:Notification) {
        if(bottomText.isFirstResponder){
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func share(_ sender: Any) {
        let controller = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        controller.completionWithItemsHandler = {
            activity, completed, items, error in
            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
        self.present(controller, animated: true, completion: nil)
    }
    @IBAction func cancel(_ sender: Any) {
        shareBtn.isEnabled = false
        imagePickerView.image = nil
        topText.text = "TOP"
        bottomText.text = "BOTTOM"

    }
  
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillHide(){
        view.frame.origin.y = 0
    }
    
    func save (){
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memeImage: generateMemedImage())
        
    }
    
    
    
    func generateMemedImage() -> UIImage {
        
        // Completed: Hide toolbar and navbar
        hideShowToolAndNavBar(b: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Completed: Show toolbar and navbar
        hideShowToolAndNavBar(b: false)
        return memedImage
    }
    
    
    func hideShowToolAndNavBar(b:Bool){
        toolbar.isHidden = b
        navbar.isHidden = b
    }
}

