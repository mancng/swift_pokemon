//
//  SingleViewController.swift
//  pokemon
//
//  Created by Rachel Ng on 1/24/18.
//  Copyright © 2018 Rachel Ng. All rights reserved.
//

import UIKit

protocol SingleViewControllerDelegate: class {
    func deletePokemon(by controller: SingleViewController, pokemonToDelete: Pokemons?)
}

class SingleViewController: UIViewController {
    
    
    weak var delegate: SingleViewControllerDelegate?
    
    var pokemonObject: Pokemons?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBAction func releaseBtnPressed(_ sender: UIButton) {
        delegate?.deletePokemon(by: self, pokemonToDelete: pokemonObject)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pokemonObject)
        if let myPokemon = pokemonObject {
            nameLabel.text = myPokemon.name
            typeLabel.text = myPokemon.type
            weightLabel.text = String(myPokemon.weight)
            numberLabel.text = String(myPokemon.number)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
