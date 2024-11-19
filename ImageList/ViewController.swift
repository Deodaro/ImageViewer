//
//  ViewController.swift
//  ImageList
//
//  Created by Alex Silber on 04.10.2024.
//

import UIKit

// = create a new screen called "ViewController"
class ViewController: UITableViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //  three constants we already created – fm, path, and items – live inside the viewDidLoad() method, and will be destroyed as soon as that method finishes
        
        //  and we use the property PICTURES to attach data to the whole ViewController type so that it will exist for as long as our screen exists
        
        let fm = FileManager.default // инстанс файл-менеджера
        let path = Bundle.main.resourcePath! //  a bundle is a directory containing our compiled program and all our assets
        let items = try! fm.contentsOfDirectory(atPath: path) // содержимое директории по указанному пути (array of strings containing filenames)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        pictures.sort()
        
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            
            vc.title = "Picture \(indexPath.row + 1) of \(pictures.count)"
            
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

