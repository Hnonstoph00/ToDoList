//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Huy Hà on 3/2/22.
//

import UIKit
protocol AddItemViewControllerDelegate : AnyObject {
    func addItemViewControllerDidCancel (
        _ controller: AddItemViewController)
    func addItemViewController (
        _ controller: AddItemViewController, didFinishAdding item: ChecklistItem)
}
class AddItemViewController: UITableViewController,UITextFieldDelegate {
    // MARK: - IBoutlets
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    weak var delegate: AddItemViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    //MARK: -IBActions
    @IBAction func cancel () {
        delegate?.addItemViewControllerDidCancel(self)
        
    }
    @IBAction func done () {
        let item = ChecklistItem()
        item.text = textField.text!
        delegate?.addItemViewController(self, didFinishAdding: item)
    }
    // MARK: - Table View Delegates
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    //MARK: - Textfield Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange,with: string)
        doneBarButton.isEnabled = !newText.isEmpty
    return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
}