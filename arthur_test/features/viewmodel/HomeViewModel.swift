//
//  HomeViewModel.swift
//  arthur_test
//
//  Created by Arthur Stapassoli on 13/03/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published private (set) var variations : [VariationItem] = []
    
    private var cancellable: Set<AnyCancellable> = []
    
    var homeService: HomeService
    var calculateVariationUseCase: CalculateVariationUseCase
    
    
    init(homeService :HomeService = HomeServiceImpl(),
         calculateVariationUseCase : CalculateVariationUseCase = CalculateVariationUseCaseImpl()
    ) {
        self.calculateVariationUseCase = calculateVariationUseCase
        self.homeService = homeService
    }
    
    func fetchData() {
        homeService.getFinancialAsset(parameter: "PETR4.SA")
            .sink {[weak self] completion in
                guard let _ = self else { return }
                switch completion {
                case .failure(let error):
                    if let _ = error.responseCode {
                        print(error)
                    }
                    if error.isSessionTaskError {
                        print(error)
                    }
                    if error.isResponseSerializationError {
                        print(error)
                    }
                case .finished:
                    break
                }
            } receiveValue: {[weak self] value in
                guard let self = self else { return }
                self.handleItems(result: value)
            }
            .store(in: &cancellable)
    }
    
    func handleItems(result: MainResult) {
        
        guard let item = result.chart?.result?.first?.indicators?.quote?.first,
              let opens = item.open
        else { return }
        
        self.variations = self.calculateVariationUseCase.execute(items: opens)
        
    }
    
}

