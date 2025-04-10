//
//  ViewController.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 09.04.2025.
//

import UIKit

protocol CharacterListDisplayLogic: AnyObject {
    func displayCharacterList(viewModel: CharacterList.FetchCharacter.ViewModel)
}

class CharacterListViewController: UITableViewController, CharacterListDisplayLogic
{
    var interactor: CharacterListBusinessLogic?
    var router: (NSObjectProtocol & CharacterListRoutingLogic & CharacterListDataPassing)?
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = CharacterListInteractor()
        let presenter = CharacterListPresenter()
        let router = CharacterListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setup()
        fetchCharacters()
        setUpUI()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: Properties
    var characters:[Character] = []
    
    //MARK: Methods
    
    //MARK: Set up UI view
    private func setUpUI(){
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func fetchCharacters()
    {
        let request = CharacterList.FetchCharacter.Request()
        interactor?.fetchCharacter(request: request)
    }
    
    func displayCharacterList(viewModel: CharacterList.FetchCharacter.ViewModel)
    {
        self.characters = viewModel.characters
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CharacterListViewController{
    // MARK: Settings for rows count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    // MARK: Settings for rows info
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let character = self.characters[indexPath.row]
        cell.selectionStyle = .gray
        cell.textLabel?.text = character.name
        cell.imageView?.image = character.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToCharacterDetails()
    }
}
