//
//  MainTableViewController.swift
//  pokemon
//
//  Created by Rachel Ng on 1/24/18.
//  Copyright © 2018 Rachel Ng. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController, AddViewControllerDelegate, TypeTableViewControllerDelegate {

    var storedPokemons: [Pokemons] = [Pokemons]()
    var storedType = [Any?]()
    var currentPokemonType = ""
    var pokemonByType: [Pokemons] = [Pokemons]()

    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAndReload()
        self.title = "Pokemon"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowAddSegue" {
            let navigationController = segue.destination as! UINavigationController
            let addViewController = navigationController.topViewController as! AddViewController
            addViewController.delegate = self
        } else {
            let typeTableViewController = segue.destination as! TypeTableViewController
            typeTableViewController.delegate = self
            typeTableViewController.newArray = pokemonByType
            typeTableViewController.typeName = currentPokemonType
        }
    }
    
    // MARK: Delegate
    func cancel(by controller: AddViewController) {
        dismiss(animated: true, completion: nil)
//        navigationController?.popViewController(animated: true)
    }
    
    func addPokemon(by controller: AddViewController, name: String?, type: String?, weight: Double?, number: Int?) {
        
        let pokemonToBeAdded = Pokemons(context: managedObjectContext)
        pokemonToBeAdded.name = name
        pokemonToBeAdded.type = type
        pokemonToBeAdded.weight = weight!
        pokemonToBeAdded.number = Int16(number!)
        dismiss(animated: true, completion: nil)
        saveData()
    }
    
    // MARK: CoreData
    func fetchAndReload() {
        let context: NSManagedObjectContext! = managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Pokemons", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        request.resultType = .dictionaryResultType
        request.returnsDistinctResults = true
        request.propertiesToFetch = ["type"]
        do {
            let results = try managedObjectContext.fetch(request)
            storedType = []
            for r in results {
                let pokemonType = r as! NSDictionary
                storedType.append(pokemonType["type"])
            }
            tableView.reloadData()
        } catch {
            print("Error from fetchAndReload \(error)")
        }
    }
    
    func fetchPokemonByType() {
        do {
            let request: NSFetchRequest<Pokemons> = Pokemons.fetchRequest()
            request.predicate = NSPredicate(format: "type CONTAINS %@", currentPokemonType)
            let results = try managedObjectContext.fetch(request) as [Pokemons]
            pokemonByType = results
        } catch {
            print("Error in fetchPokemonByType: \(error)")
        }
    }

    func saveData() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Successfullly Updated")
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        fetchAndReload()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedType.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath)
        let currentType = storedType[indexPath.row]
        
        if let finalType = currentType as! NSString? {
            if finalType == "Fire" {
                cell.backgroundColor = UIColor.orange
            } else if finalType == "Electric" {
                cell.backgroundColor = UIColor.yellow
            } else if finalType == "Grass" {
                cell.backgroundColor = UIColor.green
            } else if finalType == "Poison" {
                cell.backgroundColor = UIColor.purple
            } else if finalType == "Bug" {
                cell.backgroundColor = UIColor.green
            } else if finalType == "Dragon" {
                cell.backgroundColor = UIColor.purple
            } else if finalType == "Steel" {
                cell.backgroundColor = UIColor.lightGray
            } else if finalType == "Ice" {
                cell.backgroundColor = UIColor.blue
            } else if finalType == "Flying" {
                cell.backgroundColor = UIColor.purple
            } else if finalType == "Fairy" {
                cell.backgroundColor = UIColor.red
            } else if finalType == "Ghost" {
                cell.backgroundColor = UIColor.darkGray
            } else if finalType == "Fighting" {
                cell.backgroundColor = UIColor.red
            } else if finalType == "Psychic" {
                cell.backgroundColor = UIColor.red
            } else if finalType == "Water" {
                cell.backgroundColor = UIColor.blue
            } else if finalType == "Dark" {
                cell.backgroundColor = UIColor.brown
            } else if finalType == "Ground" {
                cell.backgroundColor = UIColor.lightGray
            }
        }
        
        cell.textLabel?.text = String(describing: currentType!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passCurrentType = storedType[indexPath.row]!
        currentPokemonType = String(describing: passCurrentType)
        fetchPokemonByType()
        performSegue(withIdentifier: "ShowTypeSegue", sender: indexPath)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchAndReload()
    }
 

}
