//
//  ViewController.swift
//  KeyboardListener
//
//  Created by 刘畅 on 2022/5/31.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let button = UIButton(frame: CGRect(x: 30, y: 100, width: 200, height: 30))
        button.setTitle("go scroll view", for: UIControl.State.normal)
        button.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(self.gotoScroll), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button)
        
        let textView = UITextView(frame: CGRect(x: 20, y: self.view.frame.height-100, width: 200, height: 45))
        textView.backgroundColor = UIColor.red
        self.view.addSubview(textView)
        
        let textField = UITextField(frame: CGRect(x: 20, y: self.view.frame.height-160, width: 200, height: 45))
        textField.backgroundColor = UIColor.yellow
        self.view.addSubview(textField)
        
        self.view.addKeyboardListener()
        
        
    }

    @objc func gotoScroll() {
        self.navigationController?.pushViewController(FirstViewController(), animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

