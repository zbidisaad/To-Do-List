//
//  ViewController.swift
//  test
//
//  Created by Saad Zbidi on 26/11/2021.
//

import UIKit

class ViewController: UIViewController {

    var item: Item?

    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var nameLable: UILabel!

    @IBOutlet weak var saveButton: UIBarButtonItem!


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

       if sender as AnyObject? === saveButton {

        let name = nameTextField.text ?? ""

        item = Item(name: name)

        }

    }


    @IBAction func cancel(_ sender: UIBarButtonItem) {

        _ = navigationController?.popViewController(animated: true)

    }

    // Do any additional setup after loading the view.

    override func viewDidLoad() {

        super.viewDidLoad()

        if let item = item {

            nameTextField.text = item.name

        }
    }
}

