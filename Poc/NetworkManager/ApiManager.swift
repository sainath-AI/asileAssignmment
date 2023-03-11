//
//  NetworkManager.swift
//  Poc
//
//  Created by APPLE on 08/03/23.
//

import Foundation

//protocol dataTransferDelegate {
//    func didSuccessdelegate()
//}


struct ApiManager {
    
 //   var delegate : dataTransferDelegate?
    
    func getdata(phNumber : String){
           
           
           let urlString = "https://app.aisle.co/V1/users/phone_number_login"
           guard let url = URL(string: urlString) else {
               print("Invalid URL")
               return
           }
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           
           // Define the request body
           let parameters = ["number": phNumber]
           do {
               let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
               request.httpBody = jsonData
           } catch {
               print("Error serializing parameters: \(error.localizedDescription)")
               return
           }
           
           // Send the request
           let session = URLSession.shared
           let task = session.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("Error making request: \(error.localizedDescription)")
                   return
               }
               guard let httpResponse = response as? HTTPURLResponse else {
                   print("Invalid response")
                   return
               }
               guard data != nil else {
                   print("Empty response")
                   return
               }
               if httpResponse.statusCode == 200 {
                   // Handle success response and navigate to next screen
                   print("API call successful")
                   //   self.delegate?.didSuccessdelegate()
               } else {
                   // Handle error response
                   print("API call failed with status code \(httpResponse.statusCode)")
               }
           }
           task.resume()
       }
       //    func fetchData(phNumber : String){
       //    let urlString = "https://app.aisle.co/V1/users/phone_number_login"
       //    guard let url = URL(string: urlString) else {
       //        print("Invalid URL")
       //        return
       //    }
       //    }
       
       
   }
