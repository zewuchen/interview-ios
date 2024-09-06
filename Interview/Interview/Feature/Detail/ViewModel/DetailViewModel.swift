//
//  DetailViewModel.swift
//  Interview
//
//  Created by Rafael Ramos on 05/09/24.
//

import Foundation

protocol DetailViewModelProtocol {
    func fetchDetail()
    func setDelegate(_ delegate: DetailViewModelOutput?)
}

protocol DetailViewModelOutput: AnyObject {
    func willLoadPokemonInfo(message: String)
    func loadedPokemonInfoWithSuccess(detail: PokemonDetailRow)
    func loadedPokemonsInfoFailure()
}

final class DetailViewModel {
    private let mathHelper: MathHelperProtocool
    private let pokemonDetailWorker: PokemonDetailWorker
    private let url: URL
    
    weak var delegate: DetailViewModelOutput?
    
    init(
        mathHelper: MathHelperProtocool,
        pokemonDetailWorker: PokemonDetailWorker,
        url: URL
    ) {
        self.mathHelper = mathHelper
        self.pokemonDetailWorker = pokemonDetailWorker
        self.url = url
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    func setDelegate(_ delegate: DetailViewModelOutput?) {
        self.delegate = delegate
    }
    
    func fetchDetail() {
        delegate?.willLoadPokemonInfo(message: "Carregando")
        
        fetchPokemonInfoDetail()
    }
}

private extension DetailViewModel {
    func fetchPokemonInfoDetail() {
        pokemonDetailWorker.fetchPokemonDetail(url: url) { [weak self] result in
            guard let self else { return }
            guard case .success(let detailresponse) = result else {
                return
            }
            
            self.delegate?.loadedPokemonInfoWithSuccess(
                detail: PokemonDetailAdapter(
                    detailResponse: detailresponse,
                    imageAsset: self.getImageAssetFromId(detailresponse.id)
                )
            )
        }
    }
    
    func getImageAssetFromId(_ id: Int?) -> String {
        guard let id else { return "placeholder" }
        
        guard !mathHelper.isNumberEven(id) else {
            return "squirtle"
        }
        
        guard !mathHelper.isNumberMultipleOf(id, multiple: 5) else {
            return "charmander"
        }
        
        return "bulbasaur"
    }
}
