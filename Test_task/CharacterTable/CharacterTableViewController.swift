//
//  ViewController.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 09.04.2025.
//

import UIKit

class CharacterTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    var tableView = UITableView()
    
    var networkManager = APIManager()
    var characters: Array<Character> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
             
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        Task{
            do{
                let loadedList = try await networkManager.getCharactersList()
                characters = loadedList
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch{
                print(error.localizedDescription)
            }
            
        }
    
    }
    
    // MARK: Settings for rows count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    // MARK: Settings for rows info
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let character = characters[indexPath.row]
        cell.selectionStyle = .gray
        cell.textLabel?.text = character.name
        cell.imageView?.image = character.image
        return cell
    }
}

