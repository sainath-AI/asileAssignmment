

import Foundation

class ApiViewModel {
    
    let postOtpUrl = "https://app.aisle.co/V1/users/verify_otp"
    let postNumberUrl = "https://app.aisle.co/V1/users/phone_number_login"
    

    
    
    
    func postOTPData(phNumber : String,otpNumber : String ,completion: @escaping (Result<ApiResponseModel, Error>) -> Void) {
        guard let url = URL(string: postOtpUrl) else {
            return completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        }
        
        let otpRequestBody = [
            "number": phNumber,
            "otp": otpNumber
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: otpRequestBody, options: []) else {
            return completion(.failure(NSError(domain: "Invalid request body", code: 0, userInfo: nil)))
        }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let responseModel = try JSONDecoder().decode(ApiResponseModel.self, from: data)
                completion(.success(responseModel))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func postNumberData( phNumber : String , completion: @escaping (Result<NumberResponseModel, Error>) -> Void) {
        guard let url = URL(string: postNumberUrl) else {
            return completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        }
        
        let numberRequestBody = [
            "number": phNumber,
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
    
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: numberRequestBody, options: []) else {
            return completion(.failure(NSError(domain: "Invalid request body", code: 0, userInfo: nil)))
        }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let responseModel = try JSONDecoder().decode(NumberResponseModel.self, from: data)
                completion(.success(responseModel))
                print("Status \(String(describing: responseModel.status))")
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
