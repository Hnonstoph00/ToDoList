//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Huy Hà on 3/2/22.
//

import UIKit
protocol ItemDetailViewControllerDelegate : AnyObject {
    func itemDetailViewControllerDidCancel (_ controller: ItemDetailViewController)
    func itemDetailViewController ( _ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
    func itemDetailViewController ( _ controller: ItemDetailViewController, didFinishingEditing item: ChecklistItem)
}
class ItemDetailViewController: UITableViewController,UITextFieldDelegate {
    // MARK: - IBoutlets
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    weak var delegate: ItemDetailViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
    }
    //MARK: -IBActions
    @IBAction func cancel () {
        delegate?.itemDetailViewControllerDidCancel(self)
        
    }
    @IBAction func done () {
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishingEditing: item)
        } else {
            let item = ChecklistItem()
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishAdding: item)
        }
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
    var itemToEdit : ChecklistItem?
}
