//
//  OpinionViewController.swift
//  BELL
//
//  Created by 최은지 on 11/06/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class OpinionViewController: UIViewController, UIGestureRecognizerDelegate  {
    
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
        
        self.OpinionTextField.text = "내용을 입력해 주세요."
        self.OpinionTextField.textColor = UIColor.gray
        
    }
    
    // MARK : tap gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
