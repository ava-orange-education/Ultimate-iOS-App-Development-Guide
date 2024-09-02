//
//  ViewController.swift
//  ToDoList
//
//  Created by Surabhi Chopada on 10/09/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var listArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.listArray = UserDefaults.standard.array(forKey: "ToDoList") as? [String] ?? []
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.lightGray
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.title = "ToDo List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addList))
    }
    
    @objc func addList(){
        let createTask = UIAlertController(title: "Enter Task", message: nil, preferredStyle: .alert)
        createTask.addTextField()
        let submit = UIAlertAction(title: "Submit", style: .default) { [unowned createTask] _ in
            if let text = createTask.textFields![0].text {
                if(text.count != 0) {
                    self.listArray.append(text)
                    UserDefaults.standard.set(self.listArray, forKey: "ToDoList")
                    UserDefaults.standard.synchronize()
                    self.tableView.reloadData()
                }
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        createTask.addAction(submit)
        createTask.addAction(cancel)
        present(createTask, animated: true)
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = listArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            listArray.remove(at: indexPath.row)
            self.tableView.reloadData()
            UserDefaults.standard.set(listArray, forKey: "ToDoList")
            UserDefaults.standard.synchronize()
        }
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "detailVC") as! DetailsViewController
        vc.titleText = self.listArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
