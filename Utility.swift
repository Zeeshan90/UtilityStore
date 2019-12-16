//
//  Utils.swift
//  WbmHealth
//
//  Created by WBM on 5/8/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class Utility: UIViewController,NVActivityIndicatorViewable {
    
    static var instance = Utils()
    let dateFormatter = DateFormatter()
    let date = Date()
    let calender = Calendar.current
    
    // MARK: CardView
    class func cardView(view:UIView){
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 1
        view.layer.cornerRadius = 10
    }
    
    // MARK: Alert
    class func showAlert(view: UIViewController , message: String, title: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        DispatchQueue.main.async {
            view.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Converting Date Functions
    // from 2019-09-23:00:00z to 2019-08-22
    // getting the complete date in Date and converting the date to short string
    // Converting a Short Date to string
    func convertShortDate(date: Date) -> String{
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale // edited
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    // Converting A Short String to Date
    func convertShortString(date: String) -> Date{
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale // edited
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let datee = dateFormatter.date(from: date)
        return datee!
    }
    
    // MARK: get time from long date
    func getTimefrmLongDate(date: String,from:String,to:String) -> String{
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale // edited
        dateFormatter.dateFormat = from
        let datee = dateFormatter.date(from: date)!
        
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale // edited
        dateFormatter.dateFormat = to
        let dateString = dateFormatter.string(from: datee)
        return dateString
    }
    
    // Converting A Long String to Long Date
    func convertLongString(date: String) -> Date{
        
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale // edited
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let datee = dateFormatter.date(from: date)
        return datee!
        
    }
    
    // Converting a Long Date to String
    func convertlongDate(date: Date) -> String{
        
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale // edited
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    // Used to get the date from the server in string and return in string to display in text field
    func convertingDate(date:String) -> String{
        let converttodate = convertLongString(date: date)
        let converttostring = convertShortDate(date: converttodate)
        return converttostring
    }
    
    // Set Search Bar in the Navigation Bar
    class func setSearchBar(controller: UIViewController,updater: UISearchResultsUpdating){
        
        var searchController = UISearchController()
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = updater
        controller.navigationItem.searchController = searchController
        controller.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barStyle = .blackTranslucent
        searchController.searchBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        searchController.isActive = true
    }
    
    // Check Email is Valid or not
    class func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    // Check ssn is Valid or not
    class func isValidSsnId(ssnId:String) -> Bool {
        let ssnid = "(^[0-9/+]{5}-[0-9/+]{7}-[0-9]{1}$)|(^\\-{3}-\\-{2}-\\-{4}$)"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", ssnid)
        return emailTest.evaluate(with: ssnId)
    }
    
    // MARK: Indicator Type
    func indicatorsTypes(i:Int) -> NVActivityIndicatorType {
        return NVActivityIndicatorType.allCases[i]
    }
    
    // MARK: Start indicator
    func startIndicator(type:Int) {
        let indicatorType = indicatorsTypes(i: type)
        let size = CGSize(width: 50, height: 50)
        self.startAnimating(size, message: "Please wait...", type: indicatorType, fadeInAnimation: nil)
    }
    
    // MARK:  Stop animating
    func stopIndicator(){
        self.stopAnimating()
    }
    
    // MARK: - Date Picker
    func datePicker(dates:AnyObject){
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = 3
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        let datePicker = DatePickerDialog(textColor: .red,
                                          buttonColor: .red,
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: true)
        datePicker.show("DatePickerDialog",
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        minimumDate: threeMonthAgo,
                        maximumDate: currentDate,
                        datePickerMode: .date) { (date) in
                            if let dt = date {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-MM-dd"
                                if ((dates as? UIButton) != nil) {
                                    dates.setTitle(formatter.string(from: dt), for: UIControl.State.normal)
                                }
                                else if ((dates as? UILabel) != nil){
                                    let field:UILabel = (dates as? UILabel)!
                                    field.text = formatter.string(from: dt)
                                }
                                else{
                                    let field:UITextField = (dates as? UITextField)!
                                    field.text = formatter.string(from: dt)
                                }
                                
                            }
        }
    }
    
    // MARK: - Time Functions
    
    // MARK:  Calculate Age using date
    func calculateAgeInYearsFromDateOfBirth (birthday: Date) -> Int {
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!
        return age
    }
    
    // MARK: Calculate Age using string
    func calculateAgeUsingString (birthday: String) -> Int {
        let now = Date()
        let calendar = Calendar.current
        let date = convertLongString(date: birthday)
        let ageComponents = calendar.dateComponents([.year], from: date, to: now)
        let age = ageComponents.year!
        return age
    }
    
    // MARK:  Converting a Short String and calculating age
    func calculateShortAgeUsingString (birthday: String) -> Int {
        let now = Date()
        let calendar = Calendar.current
        let date = convertShortString(date: birthday)
        let ageComponents = calendar.dateComponents([.year], from: date, to: now)
        let age = ageComponents.year!
        return age
    }
    
    //MARK: Get current utc Date-time
    func getCurrentUtcDateTime() -> String{
         let utcCurrent = Utils.localToUTC(date: Utils.instance.convertlongDate(date: Date()), fromFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", toFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        return utcCurrent
    }
    
    // MARK: Get current time 13:40
    func getCurrentTime() -> String{
        let hour = calender.component(.hour, from: date)
        let min = calender.component(.minute, from: date)
        let timeString = "\(hour):\(min)"
        return timeString
    }
    
    // MARK: convert Time in 12hour format
    func converTo12(time: String) -> String{
        let dateAsString = time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "h:mm"
        let Date12 = dateFormatter.string(from: date!)
        return Date12
        
    }
    // MARK: converting time to AM PM
    // 13:20 -> 1:20 PM
    func converTo12withAmPm(time: String) -> String{
        let dateAsString = time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date = dateFormatter.date(from: dateAsString)
        dateFormatter.dateFormat = "h:mm a"
        let Date12 = dateFormatter.string(from: date!)
        print("12 hour formatted Date:",Date12)
        return Date12
        
    }
    
    // MARK: Local to UTC time conversion
    static func localToUTC(date:String, fromFormat: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: dt!)
    }
    
    // MARK: Convert to seconds
    func convertToSeconds(time:String) -> Int {
        let components: Array = time.components(separatedBy: ":")
        let hours = Int(components[0]) ?? 0
        let minutesArr = components[1].components(separatedBy: " ")
        let minutes = Int(minutesArr[0]) ?? 0
        return (hours * 3600) + (minutes * 60)
    }
    
    // MARK: UTC to local conversion
    static func UTCToLocal(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: dt!)
    }
    
    // MARK: get currentTime AM-PM
    // -> 01:30 PM
    func getCurrentTimeAm() -> String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        //        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let dateString = formatter.string(from: Date())
        print(dateString)
        return dateString
    }
    
    // MARK: Get UTC current Time
    func getUtcCurrentTime() -> String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let dateString = formatter.string(from: Date())
        print(dateString)
        return dateString
    }
    
    // MARK: Add Minutes to time
    func addMinutes(time:String,minToAdd:Int) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a" //Your date format
        dateFormatter.timeZone = TimeZone.current //Current time zone
        let date = dateFormatter.date(from: time) //according to date format your date string
        print(date ?? "") //Convert String to Date
        let calendar = Calendar.current
        let add = calendar.date(byAdding: .minute, value: minToAdd, to: date!)
        let addString = dateFormatter.string(from: add!)
        return addString
        
    }
    
    // MARK: Get time difference
    // return Int
    func gettTimeDiff(savedTime:String,currentTime:String) -> Int{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        
        let date1 = formatter.date(from: savedTime)
        let date2 = formatter.date(from: currentTime)
        
        let elapsedTime = date2!.timeIntervalSince(date1!)
        
        // convert from seconds to hours, rounding down to the nearest hour
        let hours = floor(elapsedTime / 60 / 60)
        
        // we have to subtract the number of seconds in hours from minutes to get
        // the remaining minutes, rounding down to the nearest minute (in case you
        // want to get seconds down the road)
        let minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)
        
        print("\(Int(hours)) hr and \(Int(minutes)) min")
        return Int(hours)
    }
    // MARK: Get time difference
       // return String
    func gettTimeDifference(savedTime:String,currentTime:String) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        let date1 = formatter.date(from: savedTime)
        let date2 = formatter.date(from: currentTime)
        
        let elapsedTime = date2!.timeIntervalSince(date1!)
        
        // convert from seconds to hours, rounding down to the nearest hour
        let hours = floor(elapsedTime / 60 / 60)
        
        // we have to subtract the number of seconds in hours from minutes to get
        // the remaining minutes, rounding down to the nearest minute (in case you
        // want to get seconds down the road)
        let minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)
        let second  = calender.component(.second, from: date2!)
        print("\(Int(hours)) hr and \(Int(minutes)) min")
        return "\(Int(hours)):\(Int(minutes)):\(second)"
    }
    
    // MARK: Convert Json to String
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}

