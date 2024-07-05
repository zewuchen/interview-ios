import Foundation

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Não pode encontrar \(file) no bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Não pode carregar \(file) do bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Não pode decodificar \(file) do bundle.")
        }
        
        return loadedData
    }
    
    func fetchData<T: Decodable>(url: String, model: T.Type, completion:@escaping(T) -> (), failure:@escaping(Error) -> ()) {
        guard let url = URL(string: url) else { return }
            
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                // Se tiver erro, retornar o erro.
                if let error = error { failure(error) }
                return }
                
            do {
                let serverData = try JSONDecoder().decode(T.self, from: data)
                // Se tiver sucesso, retornar dados do servidor.
                completion((serverData))
                } catch {
                    // Se tiver erro, retornar o erro.
                    failure(error)
                }
        }.resume()
    }
}