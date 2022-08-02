//
//  ViewController.swift
//  DictionaryApp(UrlSession)
//
//  Created by MAC on 1.08.2022.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    //http://kasimadalan.pe.hu/sozluk/tum_kelimeler.php
    //http://kasimadalan.pe.hu/sozluk/kelime_ara.php

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var kelimeList = [Kelimeler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        getWords()
        
    }
    
    func getWords() {
        
        let url = URL(string: "http://kasimadalan.pe.hu/sozluk/tum_kelimeler.php")!
        
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            
            if error != nil || data == nil {
                print("Error:(")
                return
            }
            
            do {
                let response = try  JSONDecoder().decode(KelimelerResponse.self , from : data!)
                
                if let recievedKelimeList = response.kelimeler {
                    
                    self.kelimeList = recievedKelimeList
                }
                
                DispatchQueue.main.async {//internet üzerinden işlem yaptığımız zaman asenkron çalışması için kullanılır
                    self.tableView.reloadData()// arayüzdeki verileri yeniler
                }
                
            }catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    func searchWords(searchedWord : String) {
        
        var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/sozluk/kelime_ara.php")!)
        
        request.httpMethod = "POST"
        
        let postString = "ingilizce=\(searchedWord)"
        
        request.httpBody = postString.data(using: .utf8)
        
        
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            
            if error != nil || data == nil {
                print("Error:(")
                return
            }
            
            do {
                let response = try  JSONDecoder().decode(KelimelerResponse.self , from : data!)
                
                if let recievedKelimeList = response.kelimeler {
                    
                    self.kelimeList = recievedKelimeList
                }
                
                DispatchQueue.main.async { // arayüzdeki verileri yeniler
                    self.tableView.reloadData()
                }
                
            }catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    //TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return kelimeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let recievedWord = kelimeList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for : indexPath) as! TableViewCell
        
        cell.labelEnglish.text = recievedWord.ingilizce
        cell.labelTurkish.text = recievedWord.turkce
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "mainToDetails", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = sender as! Int?
        
        let destinationVC = segue.destination as! DetailVC
        
        destinationVC.kelime = kelimeList[index!]
    }
    
    
    
    //Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchWords(searchedWord: searchText)
    }


}

