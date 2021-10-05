//
//  ContetnVIewModel.swift
//  SwiftUI_Combine_Sample
//
//  Created by kazunori.aoki on 2021/10/05.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    
    // MARK: Variables
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<TimeModel, Error>()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var time: String = "0 seconds"
    @Published var seconds = "0"
    
    @Published var timeModel = TimeModel(seconds: 0)
    
    
    // MARK: Initialize
    init() {
        setupBind()
    }
}


// MARK: - Public
extension ContentViewModel {
    
    // MARK: Public
    func startFetch() {
        Service.fetch { result in
            switch result {
            case .success(let value):
                if value == "10" {
                    self.passthroughSubject.send(completion: .finished)
                } else {
                    self.passthroughSubject.send(value)
                }
                
                self.seconds = value
                
            case .failure(let error):
                self.passthroughSubject.send(completion: .failure(error))
                self.seconds = error.localizedDescription
            }
        }
        
        Service.fetchModel { result in
            switch result {
            case .success(let timeModel):
                self.passthroughModelSubject.send(timeModel)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


// MARK: - Setup
private extension ContentViewModel {
    
    func setupBind() {
        
        passthroughSubject
//            .dropFirst()                   // skip(1)のようなもの
//            .filter { value -> Bool in     // 通さないものを決める
//                value != "5"
//            }
//            .map { value in                // 全処理する
//                return value + " seconds"
//            }
            .sink { completion in
                switch completion {
                case .finished:
                    self.time = "Finished"
                    
                case .failure(let error):
                    self.time = error.localizedDescription
                }
                
            } receiveValue: { value in
                self.time = "\(value)"
            }
            .store(in: &cancellables)
        
        
        passthroughModelSubject
            .sink { _ in
                
            } receiveValue: { timeModel in
                self.timeModel = timeModel
            }
            .store(in: &cancellables)
    }
}
