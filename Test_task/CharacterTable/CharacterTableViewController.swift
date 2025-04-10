//
//  ViewController.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 09.04.2025.
//

import UIKit
import Combine

class CharacterTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    var tableView = UITableView()
    
    var networkManager = APIManager()
    var characters: Array<Character> = []
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadCharacters()
    }
    
    //MARK: Set up UI view
    private func setUpUI(){
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    // MARK: Get data due to internet connection
    private func loadCharacters(){
        NetworkManager.shared.$isConnected
            .receive(on: DispatchQueue.main)
            .sink { isConnected in
                if isConnected {
                    Task{
                        do{
                            let loadedList = try await self.networkManager.getCharactersListAPI()
                            self.characters = loadedList
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        } catch{
                            print(error.localizedDescription)
                        }
                    }
                }
                else {
                    self.characters = CoreDataManager.shared.fetchCharacters()
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: Settings for rows count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    // MARK: Settings for rows info
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let character = self.characters[indexPath.row]
        cell.selectionStyle = .gray
        cell.textLabel?.text = character.name
        cell.imageView?.image = character.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = self.characters[indexPath.row]
        let detailVC = CharacterDetailsViewController()
        
        detailVC.character = selectedCharacter
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

