
import Foundation

class NoteViewModel {
    
    let apiUrl = "https://app.aisle.co/V1/users/test_profile_list"
    
    func getData(completion: @escaping (Result<NoteResponseModel, Error>) -> Void) {
         guard let url = URL(string: apiUrl) else {
             completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
             return
         }
         
         var request = URLRequest(url: url)
         request.httpMethod = "GET"
         request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
         
         let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
             if let error = error {
                 completion(.failure(error))
                 return
             }
             
             guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                 completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                 return
             }
             
             guard let data = data else {
                 completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                 return
             }
             do {
                 let responseModel = try JSONDecoder().decode(NoteResponseModel.self, from: data)
                 completion(.success(responseModel))
             } catch let error {
                 completion(.failure(error))
             }
         }
         task.resume()
     }
}
