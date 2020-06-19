//
//  OpinionViewController.swift
//  BELL
//
//  Created by 최은지 on 11/06/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit
import MessageUI
import Foundation

class OpinionViewController: UIViewController, UIGestureRecognizerDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var OpinionTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
        
        self.OpinionTextField.layer.borderWidth = 1
        self.OpinionTextField.layer.borderColor = UIColor.gray.cgColor
        self.OpinionTextField.layer.cornerRadius = 5
        
        self.submitButton.layer.cornerRadius = 5
        
        if !MFMailComposeViewController.canSendMail(){
            return
        }
        
    }
    
    // MARK : tap gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    // MARK : send mail
    @IBAction func clickSendMailButton(_ sender: UIButton) {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // configure fields
        composeVC.setToRecipients(["cheunji8209@gmail.com"])
        composeVC.setSubject("customer of BELL")
        composeVC.setMessageBody(self.OpinionTextField.text, isHTML: false)
        
        let alert = UIAlertController(title: "메일을 성공적으로 보냈습니다!", message: "소중한 의견 감사드립니다. 더 나은 BELL 로 찾아뵙겠습니다.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        self.OpinionTextField.text = ""
        
        // present ViewController Modally
//        self.present(composeVC, animated: true, completion: nil)
    }
    
    
}
