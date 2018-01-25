//
//  AddViewController.swift
//  pokemon
//
//  Created by Rachel Ng on 1/24/18.
//  Copyright © 2018 Rachel Ng. All rights reserved.
//

import UIKit

protocol AddViewControllerDelegate: class {
    func addPokemon(by controller: AddViewController, name: String?, type: String?, weight: Double?, number: Int?)
    func cancel(by controller: AddViewController)
    
}

class AddViewController: UIViewController {
    
    weak var delegate: AddViewControllerDelegate?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    
    
    @IBAction func cancelBtnPressed(_ sender: UIBarButtonItem) {
        delegate?.cancel(by: self)
    }
    
    @IBAction func catchBtnPressed(_ sender: UIButton) {
        let name = nameTextField.text!
        let type = typeTextField.text!
        let weight = Double(weightTextField.text!)
        let number = Int(numberTextField.text!)
    
        
        delegate?.addPokemon(by: self, name: name, type: type, weight: weight, number: number)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.layer.borderWidth = 1
        typeTextField.layer.borderWidth = 1
        weightTextField.layer.borderWidth = 1
        numberTextField.layer.borderWidth = 1

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
