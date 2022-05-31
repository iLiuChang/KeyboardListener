//
//  FirstViewController.swift
//  KeyboardListener
//
//  Created by 刘畅 on 2022/5/31.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        
        let textView = UITextView(frame: CGRect(x: 20, y: self.view.frame.height-100, width: 200, height: 45))
        textView.backgroundColor = UIColor.red
        self.view.addSubview(textView)
        
        let textField = UITextField(frame: CGRect(x: 20, y: self.view.frame.height-160, width: 200, height: 45))
        textField.backgroundColor = UIColor.yellow
        self.view.addSubview(textField)
        
        self.view.addKeyboardListener()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
