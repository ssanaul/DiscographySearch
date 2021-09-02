//
//  DiscographyViewModel.swift
//  DiscographySearch
//
//  Created by Sul S. on 8/31/21.
//

import Foundation

class DiscographyViewModel {
    typealias CompletionHandler = (()->())?
    let apiHandler = APIManager.shared
    var tracks: [Track]?
    var err: Error?
    
    func get<T>(url: URL, type: T.Type, completionHandler: CompletionHandler) where T: Decodable  {
        apiHandler.get(url: url, type: type) { arr, err in
            self.tracks = (arr as? Discography)?.results
            self.err = err
            completionHandler?()
        }
    }
    
    func getRowCount() -> Int {
        return tracks?.count ?? 0
    }

    func getTrackAtIndex(index: Int) -> Track {
        return tracks![index]
    }
    
    func getArtistName(track: Track) -> String {
        return track.artistName
    }
    
    func getTrackName(track: Track) -> String {
        return track.trackName
    }
    
}

