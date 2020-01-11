//
//  ViewController.swift
//  pmp_ui_introduce
//
//  Created by Student on 11/7/19.
//  Copyright © 2019 Dehtiar_Olekandr. All rights reserved.
//

import UIKit

class ViewController: ViewBaseController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var viewTable: UITableView!;
    
    private var cellTypeIdentifier: String = "cellTypeIndentifier";
    
    private var detailViewControllerName: String = "DetailViewController";
    private var movieApiService = MovieApiService();
    private var fileManager = ObjectFileManager();
    private var page = 1;
    
    public var popularMovies: EntityList<MovieListItem>? {
        didSet {
            DispatchQueue.main.async {
                self.viewTable.reloadData();
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let popularMovies: EntityList<MovieListItem>? = self.fileManager.load(type: String(describing: type(of: EntityList<MovieListItem>.self)), id: self.page);
        if (popularMovies == nil) {
            movieApiService.loadPopularMovies(page: self.page, with: { response in self.afterLoadPopuplarMovies(entities: response) }, errorBlock:  super.showError);
        } else {
            self.popularMovies = popularMovies;
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.popularMovies?.results.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellTypeIdentifier, for: indexPath);
        
        cell.textLabel!.text = self.popularMovies?.results[indexPath.item].title;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVc: DetailViewController = DetailViewController(nibName: self.detailViewControllerName, bundle: nil);
            
        self.present(detailVc, animated: true, completion: nil);
        let movieId = self.popularMovies!.results[indexPath.item].movieId;
        detailVc.configure(movieId: movieId);
    }
    
    

    private func afterLoadPopuplarMovies(entities: EntityList<MovieListItem>) -> Void {
        self.popularMovies = entities;
        self.fileManager.saveData(object: entities, type: String(describing: type(of: EntityList<MovieListItem>.self)), id: self.page);
    }
}
