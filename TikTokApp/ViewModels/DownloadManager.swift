import SwiftUI
import Alamofire
import Photos


class DownloadManager {
    let token = "token"
    let tokenvalue = "0118a46e-50df-4c72-8442-63043b863a69"
    let domen = "https://backendapppoint.space/"

    var videoSavedSuccessfully = false

    func postTikTokRequest(link: String ,completionHandler: @escaping (String) -> ()) {
        let URLString = "\(domen)api/tiktokDownload"
        let parameters: [String:String] = [ "url": link, token: tokenvalue ]
        let url = URL(string: URLString)!
        AF.request(url, method: .post, parameters: parameters)
          .validate()
          .responseDecodable(of: DownloadLinkResponse.self) { response in
                switch response.result {
                case .success(let receivedData):
                    print("TikTokDownload response.error : \(String(describing: receivedData.error))")
                    print("TikTokDownload response.messages = \(String(describing: receivedData.messages.count))")
                    let tikTokdownloadLink: String = receivedData.data.url
                    completionHandler(tikTokdownloadLink)
                case .failure(let error):
                    print("Ошибка получения данных TikTokDownload: \(error)")
                }
            }
    }

    func getClipInfo(link: String ,completionHandler: @escaping (AFDataResponse<ClipInfoResponse>) -> ()) {
        let URLString = "\(domen)api/clipInfo?url=https://vt.tiktok.com/ZS2c7RWu6/"
        let parameters: [String:String] = [ "url": link, token: tokenvalue ]
        let url = URL(string: URLString)!
        AF.request(url, method: .get, parameters: parameters)
          .validate()
          .responseDecodable(of: ClipInfoResponse.self) { response in
              completionHandler(response)
            }
    }

    func getMusicTrends(completionHandler: @escaping ([SectionModel]) -> ()) {
        let URLString = "\(domen)api/collection?lang=en"
        let parameters: [String:String] = [ token: tokenvalue ]
        let url = URL(string: URLString)!

        AF.request(url, method: .get, parameters: parameters)
          .validate()
          .responseDecodable(of: TrendsResponse.self) { response in
                switch response.result {
                case .success(let receivedData):
                    print("MusicTrends response.error : \(String(describing: receivedData.error))")
                    print("MusicTrends response.messages = \(String(describing: receivedData.messages.count))")
                    let trendsMusic: [SectionModel] = receivedData.data
                    completionHandler(trendsMusic)
                case .failure(let error):
                    print("Ошибка получения данных trendsMusic: \(error)")
                }
            }
    }
    
    func downloadAndSaveVideoToGallery(videoURL: String) {
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: videoURL),
               let urlData = NSData(contentsOf: url) {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                let filePath="\(documentsPath)/tempFile.mp4"
                DispatchQueue.main.async {
                    urlData.write(toFile: filePath, atomically: true)
                    print("DONE: urlData.write(toFile: filePath, atomically: true)")
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                    }) { completed, error in
                        if completed {
                            print("Video is saved!")
                            self.videoSavedSuccessfully = true
                        }
                        if let error {
                            print("ERROR: \(error)")
                        }
                    }
                }
            } else {
                print("ERROR downloadAndSaveVideoToGallery: no url or urlData")
            }
        }

    }
    
    func downloadTrack(trackurl: String) async -> Data? {
        var mp3data: Data?
        let url = URL(string: trackurl)!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            mp3data = data
        }
        catch let error { print("Error: \(error)") }
        return mp3data
    }
    
    func saveTrack(data: Data, name: String) {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            .appendingPathComponent(name + ".mp3")
        do {
            try data.write(to: path)
            print("Saved")
        } catch let error {
            print("Error: \(error)")
        }
    }

//    func createHTTPBody(link: String) -> Data? {
//        let jsonBodyString = """
//                                {
//                                "url": \(link),
//                                \(token): \(tokenvalue)
//                                }
//                            """
//
//        let jsonBody = convertJSONStringToData(jsonString: jsonBodyString)
//        return jsonBody
//    }
//
//    func createPOSTURLRequest(httpMethod: String, httpBody: Data?) -> URLRequest {
//        let postRequest = "\(domen)api/tiktokDownload"
//        let requestURL = URL(string: postRequest)!
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = httpMethod
//        request.httpBody = httpBody
//        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
//        return request
//    }
//
//    func returnPOSTURLResponse(request: URLRequest) async throws -> PostResponseModel? {
//        do {
//            let (receivedData, urlResponse) = try await URLSession.shared.data(for: request)
//            print(urlResponse)
//            do {
//                let response = try JSONDecoder().decode(PostResponseModel.self, from: receivedData)
////                print("response.error : \(response.error)")
////                print("response.messages = \(response.messages.count)")
//                return response
//            } catch  {
//                //                print("ошибка раскодирования: \(error)")
//            }
//                return nil
//        } catch let error {
////            print("ошибка получения данных: \(error)")
//            return nil
//        }
//    }
//
//    func getClipInfo(link: String ,completionHandler: @escaping (ClipInfoModel?) -> ()) {
//        let postRequest = "https://backendapppoint.space/api/clipInfo?url=https://vt.tiktok.com/ZS2c7RWu6/"
//        let url = URL(string: postRequest)!
//        let parameters: [String:String] = [ "url": link, token: tokenvalue ]
//
//
//            AF
//            .request(url, method: .get, parameters: parameters)
//            .validate()
//            .responseDecodable(of: ClipInfoResponse.self) { response in
//                switch response.result {
//                case .success(let receivedData):
//                    print("ClipInfo response.error : \(String(describing: receivedData.error))")
//                    print("ClipInfo response.messages = \(String(describing: receivedData.messages.count))")
//                    let clipInfo: ClipInfoModel? = receivedData.data
//                    completionHandler(clipInfo)
//
//                case .failure(let error):
//                    print("ОШИБКА: \(error)")
//                }
//            }
//    }
//
//    func downLoadClipAudio(url: URL, link: String ,completionHandler: @escaping (String) -> ()) {
//        let parameters: [String:String] = [ "url": link, token: tokenvalue ]
//
//        getResponseWithAlamofire(url, parameters) { response in
//            self.resultProcessing(response) { receivedJSONData in
//                let receivedData = try? JSONDecoder().decode(PostResponseModel.self, from: receivedJSONData)
//                print("ClipAudio .error : \(String(describing: receivedData?.error))")
//                print("ClipAudio .messages = \(String(describing: receivedData?.messages.count))")
//                let returnedURL: String = receivedData?.data.url ?? ""
//                completionHandler(returnedURL)
//            }
//        }
//    }
//
//    func getMusicTrends(completionHandler: @escaping ([SectionModel]) -> ()) {
//        let parameters: [String:String] = [ token: tokenvalue ]
//        let url = URL(string: "https://backendapppoint.space/api/collection?lang=en")!
//
//        getResponseWithAlamofire(url, parameters) { response in
//            self.resultProcessing(response) { receivedJSONData in
//                let receivedData = try? JSONDecoder().decode(TrendsResponse.self, from: receivedJSONData)
//                print("MusicTrends response.error : \(String(describing: receivedData?.error))")
//                print("MusicTrends response.messages = \(String(describing: receivedData?.messages.count))")
//                let trendsMusic: [SectionModel] = receivedData?.data ?? []
//                completionHandler(trendsMusic)
//            }
//        }
//    }
//
//    func getResponseWithAlamofire(_ url: URL, _ parameters: [String:String], comletionHandler: @escaping (AFDataResponse<Data>) -> ()) {
//        AF
//            .request(url, method: .get, parameters: parameters)
//            .validate()
//            .responseData { response in
//                comletionHandler(response)
//            }
//    }
//
//    func resultProcessing(_ response: AFDataResponse<Data>, comletionHandler: @escaping (Data) -> ()) {
//        switch response.result {
//        case .failure(let error):
//            print("ОШИБКА: \(error)")
//        case .success(let data):
//            let receivedJSONData: Data = Data(data)
//            comletionHandler(receivedJSONData)
//        }
//    }
//
//    // convertations:
//    func convertJSONStringToData(jsonString: String) -> Data? {
//        return jsonString.data(using: .utf8, allowLossyConversion: false)!
//    }

    
    //    func getRequestID(link: String) async throws -> String {
    //        let response = try await returnResponse(link: link, httpMethod: "POST")
    //        print(response.data.url)
    //        return response.data.url
    //    }

    //    func getImageURLs(response: ResponseModel) -> [String] {
    //        print(response.self)
    //        var urls: [String] = []
    //        for i in (0..<response.data.result.count) {
    //            let url = response.data.result[i].url
    //            urls.append(url)
    //        }
    //        print(urls)
    //        return urls
    //    }

    //    func checkResultIsEmpty(response: ResponseModel) -> Bool {
    //        response.data.result.isEmpty
    //    }

    //    func returnNotEmptyResponse(receivedRequestID: String) async throws -> ResponseModel {
    //        var isEmpty = true
    //        var count = 0
    //        var response = ResponseModel(error: false, data: DataClass(requestID: "", status: "processing", error: "", request: Request(profileID: 0, app: nil, version: nil, gender: nil, bodyPart: nil, userPrompt: "", productionPrompt: "", ai: ""), result: []))
    //        repeat {
    //            let postRequestString = createFETCHrequest(receivedRequestID: receivedRequestID)
    //            response = try await returnResponse(postRequestString: postRequestString, httpMethod: "GET")
    //            isEmpty = checkResultIsEmpty(response: response)
    //            count += 1
    //            print(count.description)
    //            sleep(1)
    //        } while isEmpty
    //        sleep(3)
    //        return response
    //    }

}
