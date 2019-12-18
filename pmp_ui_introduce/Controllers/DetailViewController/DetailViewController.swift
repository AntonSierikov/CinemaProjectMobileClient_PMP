//
//  DetailViewController.swift
//  pmp_ui_introduce
//
//  Created by Student on 11/7/19.
//  Copyright © 2019 Dehtiar_Olekandr. All rights reserved.
//

import UIKit

class DetailViewController: ViewBaseController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var labelView: UILabel!
    @IBOutlet var textView: UITextView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var voteCountLabel: UILabel!
    @IBOutlet var voteAverageLabel: UILabel!
    
    private var movieId: Int = 0;
    
    let movieApiService = MovieApiService();
        
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    func configure(movieId: Int) {
        self.movieId = movieId
        self.removeDefaultControlValues();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        movieApiService.loadMovie(movieId: self.movieId,
            with: { response in self.initViewControls(withMovie: response) },
            errorBlock: super.showError);
    }

    func initViewControls(withMovie: Movie) -> Void {
        DispatchQueue.main.async {
            self.textView.text = withMovie.movieDescription;
            self.labelView.text = withMovie.title;
            self.voteAverageLabel.text = withMovie.voteAverage.description;
            self.voteCountLabel.text = withMovie.voteCount.description;
            self.imageView.image = withMovie.image;
        }
    }
    
    func removeDefaultControlValues() -> Void {
        self.textView.text = "";
        self.labelView.text = "";
        self.imageView.image = nil;
        self.voteAverageLabel.text = "";
        self.voteCountLabel.text = "";
    }
    
    @IBAction func onBackTouchUpInside(_ sender: UIButton){
        dismiss(animated: true, completion: nil);
    }
}
