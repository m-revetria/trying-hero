//
//  MVComic.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Alamofire
import AlamofireImage
import Decodable
import Foundation
import Opera
import RxSwift

enum MVComicType: String, Decodable {

    case comic = "Comic"
    case tradePaperback = "Trade Paperback"

}

struct MVComic {

    private static var imagesCache: [URL: UIImage] = [:]

    let resourceUri: URL

    let name: String?
    let id: Int?
    let digitalId: Int?
    let title: String?
    let issueNumber: Int?
    let variantDescription: String?
    let description: String?
    let format: MVComicType?
    let pageCount: Int?
    let urls: [MVTypedUrl]?
    let images: [MVImage]?
    let creators: MVCollection<MVCreator>?
    let characters: MVCollection<MVCharacter>?
    let stories: MVCollection<MVStory>?
    let events: MVCollection<MVEvent>?
    let dates: [MVTypedDate]?
    let textObjects: [MVTextObject]?

    func image(at index: Int = 0) -> Observable<UIImage> {
        guard let images = images, !images.isEmpty else {
            return Observable.error("No images for this comic")
        }

        let imageData = images[index]
        return Observable.create { subscriber in
            if let image = MVComic.imagesCache[imageData.url] {
                subscriber.onNext(image)
                subscriber.onCompleted()
            } else {
                Alamofire.request(imageData.url).responseImage { response in
                    if let image = response.result.value {
                        subscriber.onNext(image)
                        subscriber.onCompleted()
                    } else {
                        subscriber.onError("Couldn't fetch image: \(imageData.url)")
                    }
                }
            }

            return Disposables.create()
        }
    }
}

extension MVComic: Decodable, OperaDecodable {

    static func decode(_ json: Any) throws -> MVComic {
        return try MVComic(
            resourceUri: json => "resourceURI",
            name: json =>? "name",
            id: json =>? "id",
            digitalId: json =>? "digitalId",
            title: json =>? "title",
            issueNumber: json =>? "issueNumber",
            variantDescription: json =>? "variantDescription",
            description: json =>? "description",
            format: json =>? "format",
            pageCount: json =>? "pageCount",
            urls: json =>? "urls",
            images: json =>? "images",
            creators: json =>? "creators",
            characters: json =>? "characters",
            stories: json =>? "stories",
            events: json =>? "events",
            dates: json =>? "dates",
            textObjects: json =>? "textObjects"
        )
    }

}
