import Combine

final class Model {
    @Published var value: Int?
}

let model = Model()

final class ViewModel {
    var number: Int = -1 {
        didSet {
            print("didSet number:", number)
        }
    }
}

final class Receiver {
    var subscriptions = Set<AnyCancellable>()
    let viewModel = ViewModel()

    init() {
        model.$value
            .compactMap { $0 }
            .assign(to: \.number, on: viewModel)
            .store(in: &subscriptions)
    }
}

let receiver = Receiver()
model.value = 1
model.value = 2
model.value = nil
model.value = 4
model.value = 5
