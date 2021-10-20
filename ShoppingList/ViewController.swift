//
//  ViewController.swift
//  ShoppingList
//
//  Created by Andrei Korikov on 20.10.2021.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToolBarItems()
        addNavBarItems()
    }
    
    fileprivate func addToolBarItems() {
        let addItemAction = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptNewItem))
        addItemAction.tintColor = UIColor.systemPink
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbarItems = [spacer, addItemAction, spacer]
    }
    
    func addNavBarItems() {
        let clearAction = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearShoppingList))
        clearAction.tintColor = UIColor.systemPink
        
        let sharingAction = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareActivityWindow))
        sharingAction.tintColor = UIColor.systemPink
        
        navigationItem.leftBarButtonItem = clearAction
        navigationItem.rightBarButtonItem = sharingAction
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopItem", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func shareActivityWindow() {
        let ac = UIActivityViewController(
            activityItems: [shoppingList.joined(separator: "\n")],
            applicationActivities: nil
        )
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }

    @objc func promptNewItem() {
        let ac = UIAlertController(title: "New Shopping Item", message: "Please, enter a new item:", preferredStyle: .alert)
        ac.addTextField()
        
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [unowned ac, weak self] _ in
            guard let item = ac.textFields?[0].text else { return }
            if !item.isEmpty {
                self?.addNewItem(item)
            }
        }
        ac.addAction(confirmAction)
        present(ac, animated: true)
    }
    
    func addNewItem(_ item: String) {
        shoppingList.insert(item, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func clearShoppingList() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
}

