//
//  CharacterDetailsViewController.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 10.04.2025.
//

import Foundation
import UIKit

class CharacterDetailsViewController: UIViewController{
    
    //MARK: Properties
    var character: Character?
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var nameLabel: UILabel = createLabel("Name", .center)
    lazy var statusLabel: UILabel = createLabel("Status: ", .left)
    lazy var typeLabel: UILabel = createLabel("Type: ", .left)
    lazy var genderLabel: UILabel = createLabel("Gender: ", .left)
    lazy var originNameLabel: UILabel = createLabel("Origin: ", .left)
    lazy var locationNameLabel: UILabel = createLabel("Location: ", .left)
    lazy var dateCreatedLabel: UILabel = createLabel("Created: ", .left)
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    
    //MARK: Set up UI view
    private func setUpUI(){
        view.backgroundColor = .white
        
        if let character = self.character{
            //Scroll
            view.addSubview(scrollView)
            scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
            //Content View
            scrollView.addSubview(contentView)
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            
            // Title
            addUIElement(nameLabel, contentView.topAnchor, 20, 400, 50)
            nameLabel.text = character.name
               
            //Photo
            imageView.image = character.image
            addUIElement(imageView, nameLabel.bottomAnchor, 15, 400, 200)
            
            //Description
            addUIElement(statusLabel, imageView.bottomAnchor, 16, 300, 50)
            statusLabel.text! += character.status
            addUIElement(typeLabel, statusLabel.bottomAnchor, 16, 300, 50)
            typeLabel.text! += character.type
            addUIElement(genderLabel, typeLabel.bottomAnchor, 16, 300, 50)
            genderLabel.text! += character.gender
            addUIElement(originNameLabel, genderLabel.bottomAnchor, 16, 300, 50)
            originNameLabel.text! += character.originName
            addUIElement(locationNameLabel, originNameLabel.bottomAnchor, 16, 300, 50)
            locationNameLabel.text! += character.locationName
            addUIElement(dateCreatedLabel, locationNameLabel.bottomAnchor, 16, 300, 50)
            dateCreatedLabel.text! += convertDate(character.dateCreated)
            dateCreatedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        }
        
    }
    
    private func addUIElement(_ inputView: UIView, _ topAnchor: NSLayoutYAxisAnchor, _ topConstraintValue: CGFloat, _ width: CGFloat, _ height: CGFloat){
        contentView.addSubview(inputView)
        inputView.widthAnchor.constraint(equalToConstant: width).isActive = true
        inputView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        inputView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        inputView.topAnchor.constraint(equalTo: topAnchor, constant: topConstraintValue).isActive = true
    }
    
    private func createLabel(_ text: String, _ alignment:NSTextAlignment) -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = alignment
        label.layer.cornerRadius = 8
        return label
    }
    
    private func convertDate(_ date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
