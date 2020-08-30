//
//  UsersTable.swift
//  UsingFMDB
//
//  Created by Sose Yeritsyan on 5/23/20.
//  Copyright © 2020 Sose Yeritsyan. All rights reserved.
//

import UIKit
import FMDB

class UsersViewController: UIViewController {
    
    @IBOutlet weak var myTable: UITableView!
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibCell = UINib(nibName: "UserCell", bundle: nil)
        myTable.register(nibCell, forCellReuseIdentifier: "Cell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        users = FMDBDatabaseModel.getInstance().getAllData()

    }

}
extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserCell
        cell.configure(user)
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUp") as! SignUpViewController
        

        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        let myEmail = cell.getEmail()
        
        let user = FMDBDatabaseModel.getInstance().findUserByEmail(email: myEmail)
        
        vc.buttonText = "Save"
        vc.user = user!

        self.navigationController?.pushViewController(vc, animated: true)

    }
    /* override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        //objects.remove(at: indexPath.row)
        t.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
      } else if editingStyle == .insert {
         Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }*/
  
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
        
    }

    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {

        let action = UIContextualAction(style: .destructive, title: "Delete", handler: { _,_,_ in
            let cell = self.myTable.cellForRow(at: indexPath) as! UserCell
            let myEmail = cell.getEmail()
            FMDBDatabaseModel.getInstance().deleteRecode(email: myEmail!)
            self.users.remove(at: indexPath.row)
            self.myTable.deleteRows(at: [indexPath], with: .automatic)
        } )
        action.backgroundColor = .red
        
        return action
    }

  
}

