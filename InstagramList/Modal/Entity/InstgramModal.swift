//
//	Data.swift
//
//	Create by Dharmesh Avaiya on 24/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class InstgramModal : NSObject, NSCoding{

	var author : String!
	var authorUrl : String!
	var filename : String!
	var format : String!
	var height : Int!
	var id : Int!
	var postUrl : String!
	var width : Int!

    var isRequestOnGoing: Bool = false

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		author = dictionary["author"] as? String
		authorUrl = dictionary["author_url"] as? String
		filename = dictionary["filename"] as? String
		format = dictionary["format"] as? String
		height = dictionary["height"] as? Int
		id = dictionary["id"] as? Int
		postUrl = dictionary["post_url"] as? String
		width = dictionary["width"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if author != nil{
			dictionary["author"] = author
		}
		if authorUrl != nil{
			dictionary["author_url"] = authorUrl
		}
		if filename != nil{
			dictionary["filename"] = filename
		}
		if format != nil{
			dictionary["format"] = format
		}
		if height != nil{
			dictionary["height"] = height
		}
		if id != nil{
			dictionary["id"] = id
		}
		if postUrl != nil{
			dictionary["post_url"] = postUrl
		}
		if width != nil{
			dictionary["width"] = width
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         author = aDecoder.decodeObject(forKey: "author") as? String
         authorUrl = aDecoder.decodeObject(forKey: "author_url") as? String
         filename = aDecoder.decodeObject(forKey: "filename") as? String
         format = aDecoder.decodeObject(forKey: "format") as? String
         height = aDecoder.decodeObject(forKey: "height") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         postUrl = aDecoder.decodeObject(forKey: "post_url") as? String
         width = aDecoder.decodeObject(forKey: "width") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if author != nil{
			aCoder.encode(author, forKey: "author")
		}
		if authorUrl != nil{
			aCoder.encode(authorUrl, forKey: "author_url")
		}
		if filename != nil{
			aCoder.encode(filename, forKey: "filename")
		}
		if format != nil{
			aCoder.encode(format, forKey: "format")
		}
		if height != nil{
			aCoder.encode(height, forKey: "height")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if postUrl != nil{
			aCoder.encode(postUrl, forKey: "post_url")
		}
		if width != nil{
			aCoder.encode(width, forKey: "width")
		}

	}

}
