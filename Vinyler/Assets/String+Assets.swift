//
//  String+Assets.swift
//  Vinyler
//
//  Created by 민송경 on 14/08/2019.
//  Copyright © 2019 songkyung min. All rights reserved.
//

import Foundation

extension String {

    static let hello = NSLocalizedString("Hello.", comment: "")
    static let scan = NSLocalizedString("Click the camera button\nand scan the barcode of vinyl", comment: "")
    static let or = NSLocalizedString("or", comment: "")
    static let search = NSLocalizedString("search album\nby code or title.", comment: "")
    static let cameraPermission = NSLocalizedString("Please allow camera access to be able to scan vinyls.", comment: "")
    static let sellsFor = NSLocalizedString("From %@ on Discogs", comment: "")
    static let shipping = NSLocalizedString("shipping", comment: "")
    static let tracklist = NSLocalizedString("Tracklist", comment: "")
    static let description = NSLocalizedString("Description", comment: "")
    static let noResultsTitle = NSLocalizedString("No Results", comment: "")
    static let noResultsMessage = NSLocalizedString("Sorry, we couldn't find a match.", comment: "")
    static let ok = NSLocalizedString("Ok", comment: "")
    static let searchPlaceholder = NSLocalizedString("Search album code or title", comment: "")
    static let thanks = NSLocalizedString("Thanks for using Vinyl", comment: "")
    static let about = NSLocalizedString("Vinyl is my passion project which I decided to do because, as a vinyl collector, I needed it.\nIt uses %@ database to help you digging for vinyl records.", comment: "")
    static let discogs = "Discogs"
    static let privacyTitle = NSLocalizedString("I care about your privacy", comment: "")
    static let privacyMessage = NSLocalizedString("I’m proud to say that the %@\nThis is why, if you find any issues, crashes or just want to send feedback, I kindly ask you to do that by sending an email to %@.", comment: "")
    static let privacyMessageHighlighted = NSLocalizedString("app doesn’t collect any user information or use any 3rd party services that do so.", comment: "")
    static let email = "vinylapp@protonmail.com"
    static let instructionsTitle = NSLocalizedString("How to use", comment: "")
    static let instructionsMessage = NSLocalizedString("You can find a specific vinyl release in 2 different ways: newer releases usually have barcodes on the cover which you can scan, while you can search the older ones by entering the %@ or album/artist name. I recommend using the %@ since it’ll identify the exact release you're looking for.", comment: "")
    static let github = "GitHub"
    static let catalogNumber = NSLocalizedString("catalog number", comment: "")
    static let openSourceTitle = NSLocalizedString("Vinyl is open source", comment: "")
    static let openSourceMessage = NSLocalizedString("Since transparency is one of my core beliefs, the app is open source: %@.", comment: "")
    static let credits = NSLocalizedString("Credits", comment: "")
    static let vinylIcon = NSLocalizedString("Vinyl loader and back icons by %@.", comment: "")
    static let freepik = "Freepik"
    static let cameraIcon = NSLocalizedString("Camera icon by %@.", comment: "")
    static let smashicons = "Smashicons"
    static let appIcon = NSLocalizedString("App icon by %@.", comment: "")
    static let alexanderKahlkopf = "Alexander Kahlkopf"
    static let emailErrorTitle = "¯\\_(ツ)_/¯"
    static let emailErrorMessage = NSLocalizedString("Unfortunately, there was an error. Please try again.", comment: "")
    static let dismiss = NSLocalizedString("Dismiss", comment: "")
    static let copyToClipboard = NSLocalizedString("Copy email address", comment: "")
    static let emailSuccessTitle = "ヽ(^o^)丿"
    static let emailSuccessMessage = NSLocalizedString("You're awesome, thanks for reaching out!", comment: "")
    static let emailSuccessDismiss = NSLocalizedString("Awww, you're awesome too!", comment: "")
    static let connectionErrorTitle = "404"
    static let connectionErrorMessage = NSLocalizedString("Oops, looks like\nyou’re offline.\nWould you like to %@", comment: "")
    static let retry = NSLocalizedString("try again?", comment: "")
    static let noResultsErrorTitle = "Sorry there's no result"
    static let noResultsErrorMessage = NSLocalizedString("Sorry, we couldn’t find\nwhat you’re\nlooking for.", comment: "")
    static let genericErrorTitle = NSLocalizedString("Ooops!", comment: "")
    static let genericErrorMessage = NSLocalizedString("Unfortunately, something went wrong. Please try again.", comment: "")
    static let copy = NSLocalizedString("Copy", comment: "")
    static let releasedOn = NSLocalizedString("Released on %@", comment: "")
    static let artistDetails = NSLocalizedString("Artist details", comment: "")
    static let band = NSLocalizedString("Band", comment: "")
    static let artist = NSLocalizedString("Artist", comment: "")
    static let members = NSLocalizedString("Members:", comment: "")
    static let notAvailable = NSLocalizedString("Not available for sale on Discogs", comment: "")
    
}
