//
//  TypeTableViewController.swift
//  pokemon
//
//  Created by Rachel Ng on 1/24/18.
//  Copyright © 2018 Rachel Ng. All rights reserved.
//

import UIKit

protocol TypeTableViewControllerDelegate: class {
}

class TypeTableViewController: UITableViewController, SingleViewControllerDelegate {

    weak var delegate: TypeTableViewControllerDelegate?
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var value: String!
    var getPassedValue = ""
    var newArray = [Pokemons]()
    var singlePokemon = Pokemons()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let singleViewController = segue.destination as! SingleViewController
        singleViewController.delegate = self
        singleViewController.pokemonObject = singlePokemon
    }
    
    // MARK: Delegate
    func deletePokemon(by controller: SingleViewController, pokemonToDelete: Pokemons?) {
        
        navigationController?.popViewController(animated: true)

        // Remove the pokemon from newArray
        let index = newArray.index(of: singlePokemon)
        print("INDEX: \(String(describing: index))")
        newArray.remove(at: index!)

        // Remove the pokemon from storedData as well as core database
        managedObjectContext.delete(pokemonToDelete!)
        do {
            try managedObjectContext.save()

        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell") as! TypeTableViewCell
        let currentPokemon = newArray[indexPath.row] as Pokemons
        cell.displayName.text = String(describing: currentPokemon.name!)
        cell.displayNum.text = String(describing: Int(currentPokemon.number))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        singlePokemon = newArray[indexPath.row] as Pokemons
        performSegue(withIdentifier: "ShowSingleSegue", sender: indexPath)
    }


}
