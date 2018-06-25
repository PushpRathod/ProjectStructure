import Foundation
import Alamofire


class NetworkManager  {
    
    static let sharedInstance = NetworkManager()
    
    func funGetAllServices(_ path: String,parameter: Parameters,method: HTTPMethod, completion: @escaping (_ response: ResponseModel?, _ message: String?, _ error: Error?) -> Void) {
        
        var headers = [
            "Authorization": "\(UtilityManager.sharedInstance.getToken())",
            "Content-Type": "application/json",
        ]
        
        if method == .post {
            headers["Content-Type"] = "application/x-www-form-urlencoded"
        }
        print(path)
        print(headers)
        print(parameter)

        
        if method == .post {
            request(URL(string: path)!, method: method, parameters: parameter, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                print(response)
                if response.result.value != nil {
                    completion(ResponseModel(fromDictionary: response.result.value as! [String : Any]) , nil, nil)
                }
                else {
                    completion(nil, response.error?.localizedDescription, response.error)
                }
            }
        } else {
            Alamofire.request(
                URL(string: path)!,
                method: method,
                headers: headers).responseJSON {
                    response in
                    
                    if response.result.value != nil {
                        completion(ResponseModel(fromDictionary: response.result.value as! [String : Any]) , nil, nil)
                    }
                    else {
                        completion(nil, response.error?.localizedDescription, response.error)
                    }
            }

        }
        
        
        /*Alamofire.request(URL(string: Path.kUrgetService)!).responseArray { (response: DataResponse<[Category]>) in
            
            let category = response.result.value
            print("Category list = \(String(describing: category))")
//            if let forecastArray = forecastArray {
//                for forecast in forecastArray {
//                    print(forecast.day)
//                    print(forecast.temperature)
//                }
//            }
        }*/
    }
}
