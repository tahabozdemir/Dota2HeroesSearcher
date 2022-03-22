//  HeroManager.swift
protocol HeroManagerDelegate{
    func didUpdateHero(heroes:[HeroData])
    func didFailWithError(error:Error)
}
var heroes = [HeroData]()
import Foundation
struct HeroManager{
    var delegate:HeroManagerDelegate?
    let urlString:String = "https://api.opendota.com/api/heroStats/"
    func getHeroes(completed: @escaping ()-> ()){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data,response,error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let allHero = self.parseJSON(safeData){
                       heroes = allHero
                        self.delegate?.didUpdateHero(heroes: heroes)
                        DispatchQueue.main.async {
                            completed()
                        }
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ data: Data) -> [HeroData]?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode([HeroData].self, from: data)
            return decodedData
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

}
