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
    func loadedPokemonsInfoFailure(message: String)
}

final class DetailViewModel {
    private let pokemonDetailWorker: PokemonDetailWorker
    private let url: URL
    private let pokemonDetailAssetRuleUseCase: PokemonDetailAssetRuleUseCaseProtocol
    
    weak var delegate: DetailViewModelOutput?
    
    init(
        pokemonDetailWorker: PokemonDetailWorker,
        url: URL,
        pokemonDetailAssetRuleUseCase: PokemonDetailAssetRuleUseCaseProtocol
    ) {
        self.pokemonDetailWorker = pokemonDetailWorker
        self.url = url
        self.pokemonDetailAssetRuleUseCase = pokemonDetailAssetRuleUseCase
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    func setDelegate(_ delegate: DetailViewModelOutput?) {
        self.delegate = delegate
    }
    
    func fetchDetail() {
        delegate?.willLoadPokemonInfo(message: Constants.Strings.loading)
        fetchPokemonInfoDetail()
    }
}

private extension DetailViewModel {
    func fetchPokemonInfoDetail() {
        pokemonDetailWorker.fetchPokemonDetail(url: url) { [weak self] result in
            guard let self else { return }
            guard case .success(let detailresponse) = result else {
                self.delegate?.loadedPokemonsInfoFailure(message: Constants.Strings.errorLoading)
                return
            }
            
            self.delegate?.loadedPokemonInfoWithSuccess(
                detail: PokemonDetailAdapter(
                    detailResponse: detailresponse,
                    imageAsset: self.getImageAsset(detailresponse.id)
                )
            )
        }
    }
    
    func getImageAsset(_ id: Int?) -> String {
        pokemonDetailAssetRuleUseCase.getImageAssetFromId(id)
    }
}
